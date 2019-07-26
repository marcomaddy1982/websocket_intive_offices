//
//  Message.swift
//  App
//
//  Created by Viktor Nakyden on 25.07.19.
//

import Foundation

struct Message: Codable {
    let id: String?
    let source: SideType
    let destination: SideType
    let event: SocketEvent
    let data: String?

    /// returns a json representation of the Message object binding a passed json to a data.
    func asString() -> String? {
        guard let messageData = try? JSONEncoder().encode(self), let messageString = String(data: messageData, encoding: .utf8) else {
            return nil
        }
        return messageString
    }

    /// returns a json data object of the Message object binding a passed json to a data.
    func asData() -> Data? {
        guard let messageData = try? JSONEncoder().encode(self) else {
            return nil
        }
        return messageData
    }

    static func get<T: Codable>(type: T.Type, from string: String) -> DataMessage<T>? {
        if let data = string.data(using: .utf8), let object = try? JSONDecoder().decode(DataMessage<T>.self, from: data) {
            return object
        }
        return nil
    }


    /// Works only if `Any` is an NSObject, NSString, NSInt etc...
    static func prepare(id: String?, event: SocketEvent, data: [String: Any]) -> Message? {
        guard let objectData = try? JSONSerialization.data(withJSONObject: data, options: JSONSerialization.WritingOptions(rawValue: 0)),
            let objectString = String(data: objectData, encoding: .utf8) else {
                return nil
        }
        return Message(id: id, source: .server, destination: .client, event: event, data: objectString)
    }

    static func prepare<T: Codable>(id: String?, event: SocketEvent, data: T) -> Message? {
        guard let objectData = try? JSONEncoder().encode(data), let objectString = String(data: objectData, encoding: .utf8) else {
            return nil
        }
        return Message(id: id, source: .server, destination: .client, event: event, data: objectString)
    }
}

struct DataMessage<T: Codable>: Codable {
    let data: T? = nil
}

