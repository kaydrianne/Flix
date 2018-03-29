//
//  MovieAPIManager.swift
//  Flix
//
//  Created by TiAuna Dodd on 3/27/18.
//  Copyright © 2018 TiAuna Dodd. All rights reserved.
//

import Foundation

class MovieApiManager {
    
    static let baseUrl = "https://api.themoviedb.org/3/movie/"
    static let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
    var session: URLSession
    
    init() {
        session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
    }
    
    func nowPlayingMovies(completion: @escaping ([Movie]?, Error?) -> ()) {
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=fd8c81a8e62c3aa9e4e0939bbdb2fd68")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            //This will run when the network request returns
            if let error = error{
                print(error.localizedDescription)
                
                completion(nil, error)
                
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                let movieDictionaries = dataDictionary["results"] as! [[String: Any]]
                
                var allMovies: [Movie] = []
                
                for dictionary in movieDictionaries {
                    let movie = Movie(dictionary: dictionary)
                    allMovies.append(movie)
                }
                completion(allMovies, nil)
            }
        }
        task.resume()
    }
}
