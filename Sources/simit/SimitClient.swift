//
//  SimitClient.swift
//  simit
//
//  Created by Batuhan iOS Foreks on 1.02.2023.
//

import Foundation

@available(iOS 13.0, *)
let client = Client()

@available(iOS 13.0, *)
class Client {

    let browser = Browser()

    var connection: Connection?

    func start() {
        browser.start { [weak self] result in
            guard let self = self,
                  self.connection == nil else { return }
            print("client.handler result: \(result)")
            self.connection = Connection(endpoint: result.endpoint)
        }
    }

    
    func send(message:String){
        connection?.send(message + " ==== CLIENT")
    }
}
