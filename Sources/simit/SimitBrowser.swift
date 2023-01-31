//
//  SimitBrowser.swift
//  simit
//
//  Created by Batuhan iOS Foreks on 1.02.2023.
//

import Foundation
import Network

@available(iOS 13.0, *)
class Browser {

    let browser: NWBrowser

    init() {
        let parameters = NWParameters()
        parameters.includePeerToPeer = true

        browser = NWBrowser(for: .bonjour(type: "_simit._tcp", domain: nil), using: parameters)
    }

    func start(handler: @escaping (NWBrowser.Result) -> Void) {
        browser.stateUpdateHandler = { newState in
            print("browser.stateUpdateHandler \(newState)")
        }
        browser.browseResultsChangedHandler = { results, changes in
            for result in results {
                if case NWEndpoint.service = result.endpoint {
                    handler(result)
                }
            }
        }
        browser.start(queue: .main)
    }
}
