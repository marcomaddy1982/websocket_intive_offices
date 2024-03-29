import Vapor

/// Register your application\"s routes here.
public func routes(_ router: Router) throws {
    // Basic "It works" example
    router.get { req in
        return "It works!"
    }
    
    // Basic "Hello, world!" example
    router.get("hello") { req in
        return "Hello, world!"
    }
}

public func routes(_ wss: NIOWebSocketServer) {
    wss.get("sockets") { (ws, req) in
        let connectionTime = NSDate().timeIntervalSince1970
        ConnectionsController.shared.add(ws, at: connectionTime)
        print("Connected: \(connectionTime), total connected: \(ConnectionsController.shared.numberOfConnections)")
        //ws.send("Connected: \(connectionTime), total connected: \(ConnectionsController.shared.numberOfConnections)")

        ws.onClose.always {
            print("closed of \(connectionTime) ")
            ConnectionsController.shared.remove(connectionAt: connectionTime)
        }

        ws.onText({ (ws, message) in
            //ws.send("REQUEST FROM YOU --> \(message)")
            print("recieved: \(message)")

            guard let data = message.replacingOccurrences(of: "\\", with: "").data(using: .utf8),
                  let messageData = try? JSONDecoder().decode(Message.self, from: data),
                  messageData.destination == .server else {
                return
            }

            switch messageData.event {
            case .locations:
                if let messageToClient = Message.prepare(id: messageData.id, event: .locations, data: Location.mocks)?.asString() {
                    ws.send(messageToClient)
                    print("sent: \(messageToClient)")
                }
            case .office:
                if let locationId = LocationID(rawValue: messageData.data ?? ""), let messageToClient = Message.prepare(id: messageData.id, event: .office, data: Office.mock(for: locationId))?.asString() {
                    ws.send(messageToClient)
                    print("sent: \(messageToClient)")
                }
            default:
                break
            }
        })
    }
}
