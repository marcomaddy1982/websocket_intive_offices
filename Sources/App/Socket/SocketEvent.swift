//
//  SocketEvent.swift
//  App
//
//  Created by Viktor Nakyden on 25.07.19.
//

import Foundation

struct MessageObject: Codable {
    let message: String
}

enum SocketEvent: String, Codable {
    case message = "event send message"
    case locations = "event get locations"
    case office = "event get office"

    var type: Codable {
        switch self {
        case .message:
            return MessageObject.self as! Codable
        default:
            return String.self as! Codable
        }
    }
}

enum SideType: String, Codable {
    case server
    case client
}
