//
//  SocketEvent.swift
//  App
//
//  Created by Viktor Nakyden on 25.07.19.
//

import Foundation

enum SocketEvent: String, Codable {
    case message = "event send message"
    case locations = "event get locations"
    case office = "event get office"
}

enum SideType: String, Codable {
    case server
    case client
}
