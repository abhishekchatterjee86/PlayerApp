//
//  NetworkingWorker.swift
//  PlayerApp
//
//  Created by Abhishek Chatterjee on 23/02/18.
//  Copyright © 2018 Abhishek Chatterjee. All rights reserved.
//

import UIKit

class NetworkingWorker: NSObject {

    var networkClient: NetworkClientProtocol

    init(networkClient: NetworkClientProtocol) {
        self.networkClient = networkClient
    }

    func fetchAudioData(completionHandler handler: @escaping SyncCompletionHandler, onError: @escaping (Error) -> Void) {
        self.networkClient.fetchAudioData(completionHandler: { response, error in
            handler(response, error)
        }, onError: {_ in })
    }
}

protocol NetworkClientProtocol {
    func fetchAudioData(completionHandler handler: @escaping SyncCompletionHandler, onError: @escaping (Error) -> Void)
}
