//
//  DeliveryDataFetchRequest.swift
//  Delivery
//
//  Created by Abhishek Chatterjee on 26/01/18.
//  Copyright © 2018 Abhishek Chatterjee. All rights reserved.
//

import Foundation

private let BASE_URL: URL = URL(string: "https://gist.githubusercontent.com/anonymous/fec47e2418986b7bdb630a1772232f7d/raw/5e3e6f4dc0b94906dca8de415c585b01069af3f7/57eb7cc5e4b0bcac9f7581c8.json")!

typealias RequestParameter = (key: String, value: String)

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
}

public protocol AudioDataFetchRequest {

    associatedtype Result
    var request: URLRequest? { get }
}

protocol AudioDataFetchRequestType {

    var method: HttpMethod { get }
    var path: String { get }
    var url: URL { get }
    var params: [RequestParameter] { get }
}

extension AudioDataFetchRequestType {

    var url: URL {
        return BASE_URL.appendingPathComponent(path)
    }

    var params: [RequestParameter] {
        return []
    }

    public var request: URLRequest? {
        return URLRequest.create(method: method, url: url, params: params)
    }
}

public struct AudioDataApi {

    private init() {}

    public struct AudioDataRequest {

        private init() {}

        public struct AudioData: AudioDataFetchRequest, AudioDataFetchRequestType {

            public typealias Result = String

            var method: HttpMethod {
                return .get
            }

            var path: String {
                return ""
            }

            var params: [RequestParameter] {
                return []
            }
        }
    }
}

