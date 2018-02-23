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

class NetworkClient: NetworkClientProtocol {

    fileprivate var communicator: NetworkServiceServerCommunicationProtocol!

    init() {
        self.communicator = NetworkCommunicator()
    }

    deinit {
        self.communicator = nil
    }

    func fetchAudioData(completionHandler handler: @escaping SyncCompletionHandler, onError: @escaping (Error) -> Void) {

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

    private static func deserializeData (_ data : Data) -> Dictionary<String, AnyObject>? {
        var jsonDict : Dictionary<String, AnyObject>?
        do {
            jsonDict = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? Dictionary<String, AnyObject>
        }
        catch _ as NSError{
        }
        return jsonDict
    }
}
