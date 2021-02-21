//
//  SimitURLProtocol.swift
//  simit
//
//  Created by Batuhan Saygılı iOS Developer on 17.01.2021.
//


import UIKit

var requestCount = 0

class SimitURLProtocol: URLProtocol, URLSessionDataDelegate, URLSessionTaskDelegate {
    private var dataTask: URLSessionDataTask?
    private var urlResponse: URLResponse?
    private var receivedData: NSMutableData?
    static var configuration: SimitConfiguration?
    static var delegate:SimitURLProtocolDelegate? = nil

    class var CustomHeaderSet: String {
        return "CustomHeaderSet"
    }

    // MARK: NSURLProtocol

    override class func canInit(with request: URLRequest) -> Bool {
        if let _host = SimitURLProtocol.configuration?.host {
            guard let host = request.url?.host,host == _host else {
                return false
            }
        }
        
        if let _port = SimitURLProtocol.configuration?.port {
            guard let port = request.url?.port, port != _port else {
                return false
            }
        }
        
        if (URLProtocol.property(forKey: SimitURLProtocol.CustomHeaderSet, in: request as URLRequest) != nil) {
            return false
        }

        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {

        let mutableRequest =  NSMutableURLRequest.init(url: self.request.url!, cachePolicy: NSURLRequest.CachePolicy.useProtocolCachePolicy, timeoutInterval: 100.0)


        print(mutableRequest.allHTTPHeaderFields ?? "")
        URLProtocol.setProperty("true", forKey: SimitURLProtocol.CustomHeaderSet, in: mutableRequest)
        let defaultConfigObj = URLSessionConfiguration.default
        let defaultSession = URLSession(configuration: defaultConfigObj, delegate: self, delegateQueue: nil)
        self.dataTask = defaultSession.dataTask(with: mutableRequest as URLRequest)
        self.dataTask!.resume()

        SimitURLProtocol.delegate?.getRequest(request: mutableRequest as URLRequest)
    }

    override func stopLoading() {
        self.dataTask?.cancel()
        self.dataTask       = nil
        self.receivedData   = nil
        self.urlResponse    = nil
    }

    // MARK: NSURLSessionDataDelegate

    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask,
                    didReceive response: URLResponse,
                    completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {

        self.client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        self.urlResponse = response
        SimitURLProtocol.delegate?.getResponse(response: response)
        self.receivedData = NSMutableData()
   
        completionHandler(.allow)
    }

    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        self.client?.urlProtocol(self, didLoad: data as Data)
        SimitURLProtocol.delegate?.getData(data: data)
        self.receivedData?.append(data as Data)
    }

    // MARK: NSURLSessionTaskDelegate
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if error != nil { //&& error.code != NSURLErrorCancelled {
            self.client?.urlProtocol(self, didFailWithError: error!)
        } else {
            //saveCachedResponse()
            
            self.client?.urlProtocolDidFinishLoading(self)
        }
    }
    
    
}
