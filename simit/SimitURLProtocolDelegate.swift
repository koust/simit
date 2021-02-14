//
//  SimitURLProtocolDelegate.swift
//  simit
//
//  Created by Batuhan iOS Foreks on 13.02.2021.
//

import Foundation


protocol SimitURLProtocolDelegate {
    
    func getData(data:Data)
    func getResponse(response:URLResponse)
    func getRequest(request:URLRequest)
}
