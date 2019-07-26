import FluentSQLite
import Vapor
import WebSocket

/// Called before your application initializes.
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
    // Register providers first
    //try services.register(FluentSQLiteProvider())

    // Register routes to the router
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)

    // unknownStuff()

    // WebSocket
    let wss = NIOWebSocketServer.default()
    routes(wss)
    services.register(wss, as: WebSocketServer.self)
}

//public func unknownStuff() {
//
//    // Register middleware
//    var middlewares = MiddlewareConfig() // Create _empty_ middleware config
//    // middlewares.use(FileMiddleware.self) // Serves files from `Public/` directory
//    middlewares.use(ErrorMiddleware.self) // Catches errors and converts to HTTP response
//    services.register(middlewares)
//
//    // Configure a SQLite database
//    let sqlite = try SQLiteDatabase(storage: .memory)
//
//    // Register the configured SQLite database to the database config.
//    var databases = DatabasesConfig()
//    databases.add(database: sqlite, as: .sqlite)
//    services.register(databases)
//
//}
