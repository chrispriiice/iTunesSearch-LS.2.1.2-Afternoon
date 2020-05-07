//
//  SearchResult.swift
//  iTunesSearch
//
//  Created by Chris Price on 3/14/20.
//  Copyright © 2020 BuildWeek1x2. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
    let title: String
    let artist: String
    
    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case artist = "artistName"
    }
}

struct SearchResults: Codable {    //This was set to Decodable instead of Codable.
    let results: [SearchResult]
}
