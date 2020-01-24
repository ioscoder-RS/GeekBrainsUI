//
//  VKGroupWithNestedContainers.swift
//  GeekbrainsUI
//
//  Created by raskin-sa on 21/01/2020.
//  Copyright © 2020 raskin-sa. All rights reserved.
//

import Foundation


struct GroupVK: Decodable {
    var id: Int = 0
    var name: String = ""
    var isAdmin: Int = 0
    var lat: Double = 0.0
    
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case isAdmin = "is_admin"
        case address
    }
    
    enum AddressKeys: String, CodingKey {
        case geo
    }
    
    enum GeoKeys: String, CodingKey{
        case lat
    }
    
    init (from decoder: Decoder) throws {
        let mainContainer = try decoder.container(keyedBy: CodingKeys.self)
        let addressContainer = try mainContainer.nestedContainer(keyedBy: AddressKeys.self, forKey: .address)
        let geoContainer = try addressContainer.nestedContainer(keyedBy: GeoKeys.self, forKey: .geo)
        self.lat = try geoContainer.decode(Double.self, forKey: .lat)
        self.id = try mainContainer.decode(Int.self, forKey: .id)
    }
}

