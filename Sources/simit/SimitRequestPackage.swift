//
//  SimitRequestPackage.swift
//  simit
//
//  Created by Batuhan iOS Foreks on 13.02.2021.
//

import Foundation


struct SimitRequestPackage:Codable {
    
    var appName:String = ""
    var appVersion:String = ""
    var phoneModel:String = ""
    var bundleID:String = ""
    var deviceID:String = ""
    var deviceName:String = ""
    var deviceVersion:String = ""
    var request:SimitRequestURL!
    var response:SimitResponseURL!
    var time:Double!
    
}


struct SimitRequestURL:Codable {
    //var requestHeader:[AnyHashable:Any]?
    var requestBody:Data?
    var url:String?
    var statusCode:Int?
    var httpMethod:String?
}


struct SimitResponseURL:Codable {
    //var responseHeader:[AnyHashable:Any]?
    var responseBody:String?
    var url:String?
    var statusCode:Int?
}

