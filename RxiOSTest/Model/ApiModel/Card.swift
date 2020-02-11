//
//  Card.swift
//  RxiOSTest
//
//  Created by David Zakharyan on 10.02.2020.
//  Copyright © 2020 David Zakharyan. All rights reserved.
//

import Foundation

struct Card: Codable {
    
    let id: String?
    let name: String?
    let typeLine: String?
    let oracleText: String?
    let artist: String?
    let imageUris: CardImageUri?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case name = "name"
        case typeLine = "type_line"
        case oracleText = "oracle_text"
        case artist = "artist"
        case imageUris = "image_uris"
    }
    
    init(from decoder: Decoder)throws {
    
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decodeIfPresent(String.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        typeLine = try values.decodeIfPresent(String.self, forKey: .typeLine)
        oracleText = try values.decodeIfPresent(String.self, forKey: .oracleText)
        artist = try values.decodeIfPresent(String.self, forKey: .artist)
        imageUris = try values.decodeIfPresent(CardImageUri.self, forKey: .imageUris)
    }
}
