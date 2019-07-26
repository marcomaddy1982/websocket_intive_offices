//
//  Message.swift
//  App
//
//  Created by Viktor Nakyden on 25.07.19.
//

import Foundation

class DataObject<T: Codable>: Codable {
    let data: T

    init(data: T) {
        self.data = data
    }
}

protocol SocketMessageProtocol {
    var id: String? { get }
    var source: SideType { get }
    var destination: SideType { get }
    var event: SocketEvent { get }
}

struct MessageToServer<T: Encodable>: Encodable, SocketMessageProtocol {
    let id: String?
    let source: SideType
    let destination: SideType
    let event: SocketEvent
    let data: T

    static func prepare<T: Codable>(id: String?, event: SocketEvent, data: T) -> MessageToServer<T>? {
        return MessageToServer<T>(id: id, source: .server, destination: .client, event: event, data: data)
    }

    /// returns a json representation of the Message object binding a passed json to a data.
    func asString() -> String? {
        guard let messageData = try? JSONEncoder().encode(self), let messageString = String(data: messageData, encoding: .utf8) else {
            return nil
        }
        return messageString
    }
}

struct Message: Codable, SocketMessageProtocol {
    let id: String?
    let source: SideType
    let destination: SideType
    let event: SocketEvent
    let decoder: Decoder

    enum CodingKeys: String, CodingKey {
        case source, id, destination, event
    }

    enum DataCodingKeys: String, CodingKey {
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        source = try container.decode(SideType.self, forKey: .source)
        destination = try container.decode(SideType.self, forKey: .destination)
        event = try container.decode(SocketEvent.self, forKey: .event)
        self.decoder = decoder
    }

    func getValue<T>() -> T? {
        guard let dataContainer = try? decoder.container(keyedBy: DataCodingKeys.self) else {
            return nil
        }
        switch event {
        case .message:
            return (try? dataContainer.decode(TestMessageObject.self, forKey: .data)) as? T
        default:
            return (try? dataContainer.decode(String.self, forKey: .data)) as? T
        }
    }

    static func get<T: Codable>(type: T.Type, from string: String) -> DataMessage<T>? {
        if let data = string.data(using: .utf8), let object = try? JSONDecoder().decode(DataMessage<T>.self, from: data) {
            return object
        }
        return nil
    }
}

struct DataMessage<T: Codable>: Codable {
    let data: T? = nil
}

