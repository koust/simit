//
//  SimitLoading.swift
//  simit
//
//  Created by Batuhan iOS on 17.01.2021.
//

import UIKit
import Bonjour


public class SimitLoading: NSObject {
    
    private static var configuration:SimitConfiguration? = nil

    private var packageData:SimitRequestPackage = SimitRequestPackage()
    
    let bonjour = BonjourSession(configuration: .init(serviceType: "simit", defaults: .standard, security: .default, invitation: .automatic))
    
    public static func start(configuration:SimitConfiguration? = nil){
        
        SimitLoading().setDelegate()
        
        //Set Your Configuration
        if let _configuration = configuration {
            SimitURLProtocol.configuration = _configuration
            SimitLoading.configuration   = _configuration
        }
        
        
        // Listen Requests
        URLProtocol.registerClass(SimitURLProtocol.self)
    }
    
    private func setDelegate(){
        bonjour.start()
        
        // On start receiving large package of data.
        bonjour.onStartReceiving = { (resourceName, pr) in
            
            print("onStartReceiving",resourceName,pr)
        }

        // Track large package of data receiving progress.
        bonjour.onReceiving = { (resourceName,pr, progress) in
            
            print("onReceiving",resourceName,pr,progress)
        }

        // On finish receiving large package of data.
        bonjour.onFinishReceiving = { (resourceName, pr, localURL, error) in
            
            print("onFinishReceiving",resourceName,pr,localURL,error)
        }

        // On small package of data receive.
        bonjour.onReceive = { data, peer in
            
            print("onReceive",data,peer)
        }

        // On new peer discovery.
        bonjour.onPeerDiscovery = { peer in
            
            print("onPeerDiscovery",peer)
        }

        // On loss of peer.
        bonjour.onPeerLoss = { peer in
            
            print("onPeerLoss",peer)
        }

        // On connection to peer.
        bonjour.onPeerConnection = { peer in
            
            print("onPeerConnection",peer)
        }

        // On disconnection from peer.
        bonjour.onPeerDisconnection = { peer in
            
            print("onPeerDisconnection",peer)
        }

        // On update of list of available peers.
        bonjour.onAvailablePeersDidChange = { availablePeers in
            
            print("availablePeers",availablePeers)
        }
        
        SimitURLProtocol.delegate = self
    }
    
    /* The application current name. */
    private func getAppName() -> String {
        let appDisplayName = Bundle.main.infoDictionary?["CFBundleName"] as? String
        return appDisplayName ?? "unknown name"
    }
    
    
    
    /* The application current version. */
    private func getApppVersion() -> String {
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        return appVersion ?? "unknown version"
    }
    
    
    /* Phone model name. */
    private func getPhoneModel() -> String {
        let modelName = UIDevice.modelName
        
        return modelName
    }
    
    
    private func getBundleID() -> String {
        let bundleID = Bundle.main.bundleIdentifier
        
        return bundleID ?? "unknown bundleID"
    }
    
    private func setDevicePackageData(){
        packageData.appName = self.getAppName()
        packageData.appVersion = self.getApppVersion()
        packageData.phoneModel = self.getPhoneModel()
        packageData.bundleID = self.getBundleID()
    }
}


extension SimitLoading:SimitURLProtocolDelegate {
    func getData(data: Data) {
        if let _configuration = SimitLoading.configuration,_configuration.debug {
            
            print("==========DATA=========",data.toString() ?? "")
        }
        
        packageData.response.responseBody = data
        
        
    }
    
    func getResponse(response: URLResponse) {
        if let _configuration = SimitLoading.configuration,_configuration.debug {
            
            print("==========RESPONSE=========",response)
        }


        var simitResponse = SimitResponseURL()
        simitResponse.url = response.url?.absoluteString ?? "UNKNOWN RESPONSE URL"
        simitResponse.responseHeader = (response as? HTTPURLResponse)?.allHeaderFields
        simitResponse.statusCode = (response as? HTTPURLResponse)?.statusCode
        
        
        packageData.response = simitResponse
    }
    
    func getRequest(request: URLRequest) {
        if let _configuration = SimitLoading.configuration,_configuration.debug {
            
            print("==========REQUEST=========",request)
            print("==========REQUESTBODY=========",request.httpBody as Any)
            print("==========REQUESTHEADER=========",request.allHTTPHeaderFields as Any)
            print("==========REQUESTMETHOD=========",request.httpMethod as Any)
            
        }
        
        self.setDevicePackageData()
        
        
        
        var simitRequest = SimitRequestURL()
        simitRequest.requestBody = request.httpBody
        simitRequest.requestHeader = request.allHTTPHeaderFields
        simitRequest.httpMethod  = request.httpMethod
        simitRequest.url = request.url?.absoluteString ?? "UNKNOWN REQUEST URL"
        
        
        
        packageData.request = simitRequest
    }
    
    
}
