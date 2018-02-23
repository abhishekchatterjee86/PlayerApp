//
//  NetworkCommunicator.swift
//  Delivery
//
//  Created by Abhishek Chatterjee on 26/01/18.
//  Copyright © 2018 Abhishek Chatterjee. All rights reserved.
//

import Foundation

typealias ServerCompletionHandler = (_ serverResponseObject: NetworkServiceResponseHolder) -> Void

protocol NetworkServiceServerCommunicationProtocol {
    func connectToServerWithRequest(_ request: URLRequest, completionHandler handler: ServerCompletionHandler?)
}

class NetworkCommunicator : NetworkServiceServerCommunicationProtocol {

    func connectToServerWithRequest(_ request: URLRequest, completionHandler handler: ServerCompletionHandler?) {
        let session = URLSession(configuration: URLSessionConfiguration.ephemeral)
        let dataTask = session.dataTask(with: request as URLRequest) { (data, response, error) in
            let consentResponseHolder = NetworkServiceResponseHolder(inData: data as Data?, inResponse: response as! HTTPURLResponse, inError: error as NSError?)
            handler?(consentResponseHolder)
        }
        
        dataTask.resume()
        session.finishTasksAndInvalidate()
    }
}

class NetworkServiceResponseHolder {

    var data: Data?
    var response: HTTPURLResponse
    var error: NSError?

    init (inData: Data?, inResponse: HTTPURLResponse, inError: NSError?) {
        self.data = inData
        self.response = inResponse
        self.error = inError
    }
}


