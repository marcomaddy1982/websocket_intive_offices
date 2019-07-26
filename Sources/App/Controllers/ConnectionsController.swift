//
//  ConnectionsController.swift
//  App
//
//  Created by Viktor Nakyden on 25.07.19.
//

import Foundation
import Vapor

final class ConnectionsController {
    static var shared = ConnectionsController()

    private var connections: [Double: WebSocket] = [:]

    var numberOfConnections: Int {
        return connections.count
    }

    func add(_ connection: WebSocket, at time: TimeInterval) {
        connections[time] = connection
    }

    func remove(connectionAt time: TimeInterval) {
        connections[time] = nil
    }
}
