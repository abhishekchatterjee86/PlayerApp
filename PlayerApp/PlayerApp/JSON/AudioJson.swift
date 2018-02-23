//
//  AudioJson.swift
//  PlayerApp
//
//  Created by Abhishek Chatterjee on 23/02/18.
//  Copyright © 2018 Abhishek Chatterjee. All rights reserved.
//

import Foundation

public protocol Deserializable {
    static func create(_ dict: [AnyHashable:Any]) -> Self?
}

extension Audios: Deserializable {

    public static func create(_ dict: [AnyHashable:Any]) -> Audios? {
        guard
            let items = dict["data"] as? [[AnyHashable:Any]]
            else { return nil }
        return Audios(items: items.flatMap(Audio.create))
    }
}

extension Audio: Deserializable {

    public static func create(_ dict: [AnyHashable:Any]) -> Audio? {
        guard
            let id = dict["id"] as? String
        else { return nil }

        let title = dict["name"] as? String

        let createdOnDate = dict["createdOn"] as? String
        let modifiedDate = dict["modifiedOn"] as? String

        guard
            let audioLink = dict["audioLink"] as? String
        else { return nil }

        return Audio(id: Id(id), name: title!, createdOnDate: createdOnDate, modifiedOnDate: modifiedDate, audioFileUrl: audioLink, author: Audio.Author.create(dict["author"] as! [AnyHashable : Any]), imageLinks: Audio.ImageLinks.create(dict["picture"] as! [AnyHashable : Any]))
    }
}

extension Audio.Author: Deserializable {
    public static func create(_ dict: [AnyHashable : Any]) -> Audio.Author? {
        guard
            let name = dict["name"] as? String
        else { return nil }

        return Audio.Author(name: name, imageLinks: Audio.ImageLinks.create(dict["picture"] as! [AnyHashable : Any])!)
    }
}

extension Audio.ImageLinks: Deserializable {
    public static func create(_ dict: [AnyHashable : Any]) -> Audio.ImageLinks? {
        let smallImageUrl = dict["name"] as? String
        let mediumImageUrl = dict["name"] as? String
        let largeImageUrl = dict["name"] as? String
        let thumbnailImage = dict["name"] as? String

        return Audio.ImageLinks(smallImageUrl: smallImageUrl, mediumImageUrl: mediumImageUrl, largeImageUrl: largeImageUrl, thumbnailImage: thumbnailImage)
    }
}

