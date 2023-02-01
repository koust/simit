//
//  SimitLoading.swift
//  simit
//
//  Created by Batuhan iOS on 17.01.2021.
//

import UIKit
import Ciao


public class SimitLoading: NSObject {
    
    private static var configuration:SimitConfiguration? = nil

    private var packageData:SimitRequestPackage = SimitRequestPackage()
    
    private let ciaoBrowser = CiaoBrowser()
    
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
        // get notified when a service is found
        ciaoBrowser.serviceFoundHandler = { service in
            print("Service found")
            print(service)
        }

        // register to automatically resolve a service
        ciaoBrowser.serviceResolvedHandler = { service in
            print("Service resolved")
            do {
                
               let netService = try service.get()
               var resolver = CiaoResolver(service:netService)
                
                resolver.resolve(withTimeout: 0) { (result: Result<NetService, ErrorDictionary>) in
                    print(result)
                }
            }catch {
                print("Service resolved error")
            }
        }

        ciaoBrowser.serviceRemovedHandler = { service in
            print("Service removed")
            print(service)
        }
        
        
      

        
        ciaoBrowser.browse(type: .tcp("simit"))
        
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
