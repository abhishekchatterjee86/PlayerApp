//
//  NetworkClient.swift
//  Delivery
//
//  Created by Abhishek Chatterjee on 26/01/18.
//  Copyright © 2018 Abhishek Chatterjee. All rights reserved.
//

import Foundation

public typealias SyncCompletionHandler = (_ result: AnyObject?, _ error: Error?) -> Void

public enum NetworkClientError: Error {
    case unknown
    case httpRequestFailed(response: HTTPURLResponse, data: Data)
    case deserializationFailed(data: Data)
}

enum Either<L, R> {
    case left(L)
    case right(R)
}

class NetworkClient {

    private var httpClient: NetworkCommunicator

    public init(session: URLSession) {
        self.httpClient = NetworkCommunicator(session: session)
    }

    public func fetchAudioData<A: AudioDataFetchRequest, B: Deserializable>(_ request: A, onSuccess: @escaping (B) -> Void, onError: @escaping (Error) -> Void) -> URLSessionDataTask
        where A.Result == B {
            guard let req = request.request else {
                onError(NetworkClientError.unknown)
                return URLSessionDataTask()
            }
            
            return httpClient.execute(
                request: req,
                completionHandler: { (data, response, error) in
                    switch NetworkClient.getResponse(data: data, response: response, error: error) {
                    case let .left(error):
                        onError(error)
                    case let .right((_, d)):
                        guard let deserialized = NetworkClient.deserialize(data: d, converter: B.create) else {
                            onError(NetworkClientError.deserializationFailed(data: d))
                            return
                        }
                        onSuccess(deserialized)
                    }
            })
    }

    private static func getResponse(data: Data?, response: HTTPURLResponse?, error: Error?) -> Either<Error, (HTTPURLResponse, Data)> {
        if let error = error {
            return .left(error)
        } else if let response = response, let data = data {
            return 200..<300 ~= response.statusCode ?
                .right((response, data)) :
                .left(NetworkClientError.httpRequestFailed(response: response, data: data))
        } else {
            return .left(NetworkClientError.unknown)
        }
    }

    private static func deserialize<T>(data: Data, converter: ([AnyHashable:Any]) -> T?) -> T? {
        do {
            guard let json = try JSONSerialization.jsonObject(with: data) as? [AnyHashable:Any] else {
                return nil
            }
            return converter(json)
        } catch {
            return nil
        }
    }
}
