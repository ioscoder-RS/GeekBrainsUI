//
//  VKPhotos.swift
//  GeekbrainsUI
//
//  Created by raskin-sa on 20/01/2020.
//  Copyright © 2020 raskin-sa. All rights reserved.
//

import Foundation


// MARK: - Item
struct VKPhoto: Codable {
    let id, albumID, ownerID: Int
    let sizes: [Size]
    let text: String
    let date: Int

    enum CodingKeys: String, CodingKey {
        case id
        case albumID = "album_id"
        case ownerID = "owner_id"
        case sizes
        case text, date
    }
}

// MARK: - Size
struct Size: Codable {
    let type: String
    let url: String
    let width, height: Int
}


// MARK: - Welcome
struct PhotosResponse: Codable {
    let response: PhotosResponseData
}

// MARK: - Response
struct PhotosResponseData: Codable {
    let count: Int
    let items: [VKPhoto]
}

var myPhotos = [VKPhoto]()
