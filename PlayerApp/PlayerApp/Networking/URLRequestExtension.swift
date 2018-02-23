//
//  URLRequestExtension.swift
//  Delivery
//
//  Created by Abhishek Chatterjee on 26/01/18.
//  Copyright © 2018 Abhishek Chatterjee. All rights reserved.
//

import Foundation

extension URLRequest {

    static func create(method: HttpMethod, url: URL, params: [RequestParameter]) -> URLRequest? {
        let ps = getParams(params: params)
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        components?.queryItems = ps.map({ URLQueryItem(name: $0.key, value: $0.value) })
        var request = components?.url.map({ URLRequest(url: $0) })
        request?.httpMethod = method.rawValue

        return request
    }

    private static func getParams(params: [RequestParameter]) -> [RequestParameter] {
        return params
    }
}
