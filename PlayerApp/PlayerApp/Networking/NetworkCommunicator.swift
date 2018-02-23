//
//  NetworkCommunicator.swift
//  Delivery
//
//  Created by Abhishek Chatterjee on 26/01/18.
//  Copyright © 2018 Abhishek Chatterjee. All rights reserved.
//

import Foundation

enum HttpClientError: Error {
    case unknown
    case nonHTTPResponse(response: URLResponse)
}

class NetworkCommunicator: NSObject {

    private let session: URLSession

    init(session: URLSession) {
        self.session = session
    }

    func execute(request: URLRequest, completionHandler: @escaping (Data?, HTTPURLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
            guard let response = response, let data = data else {
                completionHandler(nil, nil, HttpClientError.unknown)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                completionHandler(data, nil, HttpClientError.nonHTTPResponse(response: response))
                return
            }
            completionHandler(data, httpResponse, error)
        })
        return task
    }
}


