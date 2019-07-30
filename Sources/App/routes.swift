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

        ws.onText({ (ws, incommingSocketMessage) in
            //ws.send("REQUEST FROM YOU --> \(message)")
            print("recieved: \(incommingSocketMessage)")

            guard let jsonData = incommingSocketMessage.replacingOccurrences(of: "\\", with: "").data(using: .utf8),
                  let message = try? JSONDecoder().decode(IncommingMessage.self, from: jsonData),
                  message.destination == .server else {
                return
            }

            switch message.event {
            case .message:
                if let testMessage: TestMessageObject = message.data() {
                    ws.send(testMessage.message)
                }
            case .locations:
                if let messageToClient = OutcommingMessage<[Location]>.prepare(id: message.id, event: .locations, data: Location.mocks)?.asString() {
                    ws.send(messageToClient)
                    print("sent: \(messageToClient)")
                }
            case .office:
                if let locationId: String = message.data(), let loc = LocationID(rawValue: locationId), let messageToClient = OutcommingMessage<[Office]>.prepare(id: message.id, event: .locations, data: loc.offices)?.asString() {
                    ws.send(messageToClient)
                    print("sent: \(messageToClient)")
                }
            }
        })
    }
}
