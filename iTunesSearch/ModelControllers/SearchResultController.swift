//
//  SearchResultController.swift
//  iTunesSearch
//
//  Created by Lambda_School_Loaner_201 on 3/14/20.
//  Copyright © 2020 BuildWeek1x2. All rights reserved.
//

import Foundation

class SearchResultController {
    
    let baseURL = URL(string: "https://itunes.apple.com/search")!
    var searchResults: [SearchResult] = []
    
    func performSearch(for searchTerm: String, resultType: ResultType, completion: @escaping () -> Void) {
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        
        let parameters: [String: String] = ["term": searchTerm, "entity": resultType.rawValue]
        let queryItems = parameters.compactMap({ URLQueryItem(name: $0.key, value: $0.value) })
        urlComponents?.queryItems = queryItems
        
        guard let requestURL = urlComponents?.url else { return }
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error { NSLog("Error fetching data: \(error)") }
            guard let data = data else { completion(); return }
            
            let jsonDecoder = JSONDecoder()
            
            do {
                let searchResults = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults = searchResults.results
            } catch {
                print("Unable to decode data into object of type [SearchResult]: \(error)")
            }
            
            completion()
        }
        
        dataTask.resume()
    }
}

