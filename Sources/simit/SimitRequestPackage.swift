//
//  SimitRequestPackage.swift
//  simit
//
//  Created by Batuhan iOS Foreks on 13.02.2021.
//

import Foundation


struct SimitRequestPackage {
    
    var appName:String = ""
    var appVersion:String = ""
    var phoneModel:String = ""
    var bundleID:String = ""
    var request:SimitRequestURL!
    var response:SimitResponseURL!
    
}


struct SimitRequestURL {
    var requestHeader:[AnyHashable:Any]?
    var requestBody:Data?
    var url:String?
    var httpMethod:String?
}


struct SimitResponseURL {
    var responseHeader:[AnyHashable:Any]?
    var responseBody:Data?
    var url:String?
    var statusCode:Int?
}

