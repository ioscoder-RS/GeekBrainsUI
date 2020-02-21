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
    let sizes: [VKPhotoSizes]
   // let smallPhoto, midPhoto, bigPhoto: String
    let text: String
    let date, postID: Int?
    let likes: VKPhotoLikes?
    let reposts: PhotoReposts?
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
struct VKPhotoSizes: Codable {
    let type: String
    let url: String
    let width, height: Int
    
    func toRealm() -> PhotoSizesRealm {
        let photoRealm = PhotoSizesRealm()
        photoRealm.url = url
        photoRealm.type = type
        photoRealm.width = width
        photoRealm.height = height
        
        return photoRealm
    }
}

// MARK: - Likes
struct VKPhotoLikes: Codable {
    let userLikes, count: Int

    enum CodingKeys: String, CodingKey {
        case userLikes = "user_likes"
        case count
    }
    
    func toRealm() -> PhotoLikesRealm {
        let photoLikeRealm = PhotoLikesRealm()
        photoLikeRealm.userLikes = userLikes
        photoLikeRealm.count = count
        
        return photoLikeRealm
    }
}//struct VKPhotoLikes: Codable

// MARK: - Reposts
struct PhotoReposts: Codable {
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


