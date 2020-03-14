//
//  SearchResult.swift
//  iTunesSearch
//
//  Created by Chris Price on 3/14/20.
//  Copyright © 2020 BuildWeek1x2. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
    var title: String
    var creator: String
    
    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case creator = "artistName"
    }
}

struct SearchResults {
    let results: [SearchResult]
}
