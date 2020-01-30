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
   // let smallPhoto, midPhoto, bigPhoto: String
    let text: String
    let date, postID: Int?
    let likes: Likes?
    let reposts: Reposts?
    let lat, long: Double?

    enum CodingKeys: String, CodingKey {
        case id
        case albumID = "album_id"
        case ownerID = "owner_id"
        case sizes
        case text, date
        case postID = "post_id"
        case likes, reposts, lat, long
    }
}

// MARK: - Size
struct Size: Codable {
    let type: String
    let url: String
    let width, height: Int
}

// MARK: - Likes
struct Likes: Codable {
    let userLikes, count: Int

    enum CodingKeys: String, CodingKey {
        case userLikes = "user_likes"
        case count
    }
}

// MARK: - Reposts
struct Reposts: Codable {
    let count: Int
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

var webVKPhotos = [VKPhoto]()
