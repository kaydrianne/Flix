//
//  Movie.swift
//  Flix
//
//  Created by TiAuna Dodd on 3/27/18.
//  Copyright © 2018 TiAuna Dodd. All rights reserved.
//

import Foundation

class Movie {
    var title: String
    var overview:String
    var posterUrl: URL?
    
    init(dictionary: [String: Any]) {
        title = dictionary["title"] as? String ?? "No title"
        overview = dictionary["overview"] as? String ?? "No overview"
        
        
        
        let movieUrlStr = dictionary["poster_path"] as! String
        //base url
        let baseURLString = "https://image.tmdb.org/t/p/w500"
        
        posterUrl = URL(string: baseURLString + movieUrlStr)!
        
        // Set the rest of the properties
        
    }
}

