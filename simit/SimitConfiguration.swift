//
//  SimitConfiguration.swift
//  simit
//
//  Created by Batuhan/Koust on 13.02.2021.
//

import Foundation


/// If you want a domain filter, you can use the host variable. It'll accept only same requets.
/// ```
/// host ex: google.com
/// port ex: 80
/// debug = false default: false
/// socketIPAddress:String? default: localhost
/// socketPort:Int? default: nil
/// ```
public struct SimitConfiguration {

    var host:String? //ex: google.com
    var port:Int? //ex: 80
    var debug:Bool = false //default: false
    var socketIPAddress:String? //default: localhost
    var socketPort:Int? //default: nil

    public init(host:String? = nil,port:Int? = nil,socketIPAddress:String? = nil,socketPort:Int? = nil,debug:Bool = false){
        self.host = host
        self.port = port
        self.debug = debug
        self.socketIPAddress = socketIPAddress
        self.socketPort = socketPort
    }
}
