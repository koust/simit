//
//  SimitServer.swift
//  simit
//
//  Created by Batuhan iOS Foreks on 1.02.2023.
//


import Foundation
import Network
import UIKit

@available(iOS 13.0, *)
let server = try? Server()

@available(iOS 13.0, *)
class Server {

    let listener: NWListener

    var connections: [Connection] = []

    init() throws {
        let tcpOptions = NWProtocolTCP.Options()
        tcpOptions.enableKeepalive = true
        tcpOptions.keepaliveIdle = 2

        let parameters = NWParameters(tls: nil, tcp: tcpOptions)
        parameters.includePeerToPeer = true
        listener = try NWListener(using: parameters)
        
        listener.service = NWListener.Service(name: "server", type: "_simit._tcp")
    }

    func start() {
        listener.stateUpdateHandler = { newState in
            print("listener.stateUpdateHandler \(newState)")
        }
        listener.newConnectionHandler = { [weak self] newConnection in
            print("listener.newConnectionHandler \(newConnection)")
            let connection = Connection(connection: newConnection)
            self?.connections += [connection]
        }
        listener.start(queue: .main)
    }

    func send() {
        connections.forEach {
            $0.send("super message from the server! \(Int(Date().timeIntervalSince1970))")
        }
    }
}
