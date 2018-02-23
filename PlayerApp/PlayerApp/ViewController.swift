//
//  ViewController.swift
//  PlayerApp
//
//  Created by Abhishek Chatterjee on 23/02/18.
//  Copyright © 2018 Abhishek Chatterjee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.fetchList()
    }

    //MARK: Fetch Audio
    func fetchList() {
        let session = URLSession.shared
        let client = NetworkClient(session: session)
        let request = AudioDataApi.AudioDataRequest.AudioData()
        let task: URLSessionDataTask = client.fetchAudioData(request, onSuccess: {audios in
            print(audios)
        }, onError: { error in NSLog("\(error)") })
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

