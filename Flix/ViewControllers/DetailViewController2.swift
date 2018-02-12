//
//  DetailViewController2.swift
//  Flix
//
//  Created by TiAuna Dodd on 2/11/18.
//  Copyright © 2018 TiAuna Dodd. All rights reserved.
//

import UIKit

class DetailViewController2: UIViewController {

    @IBOutlet weak var backdropImageView: UIImageView!
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var releasedateLabel: UILabel!
    
    @IBOutlet weak var overviewLabel: UILabel!
    
      var movie: [String: Any]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let movie =  movie{
            titleLabel.text = movie["title"] as? String
            releasedateLabel.text = movie["release_date"] as? String
            overviewLabel.text = movie["overview"] as? String
            let backdropPathString = movie["backdrop_path"] as! String
            let posterPathString = movie["poster_path"] as! String
            let baseURLString = "https://image.tmdb.org/t/p/w500"
            
            let backdropURL = URL(string: baseURLString + backdropPathString)!
            backdropImageView.af_setImage(withURL: backdropURL)
            
            let posterURL = URL(string: baseURLString + posterPathString)!
            posterImageView.af_setImage(withURL: posterURL)
        
    }

        func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
}
