//
//  Audio.swift
//  PlayerApp
//
//  Created by Abhishek Chatterjee on 23/02/18.
//  Copyright © 2018 Abhishek Chatterjee. All rights reserved.
//

import UIKit

public struct Id<T> {
    public let value: String
    public init(_ value: String) {
        self.value = value
    }
}

public struct Audios {
    public let items: [Audio]
}

public struct Audio {
    public let id: Id<Audio>
    public let name: String
    public let createdOnDate: String?
    public let modifiedOnDate: String?
    public let audioFileUrl: String
    public let author: Author?
    public let imageLinks: ImageLinks?

    public struct Author {
        public let name: String?
        public let imageLinks: ImageLinks
    }

    public struct ImageLinks {
        public let smallImageUrl: String?
        public let mediumImageUrl: String?
        public let largeImageUrl: String?
        public let thumbnailImage: String?
    }
}
