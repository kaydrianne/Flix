//
//  DetailViewController.swift
//  Flix
//
//  Created by TiAuna Dodd on 2/11/18.
//  Copyright © 2018 TiAuna Dodd. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    
    @IBOutlet weak var backDropImageView: UIImageView!
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var posterLabel: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releasedateLabel: UILabel!
    
    @IBOutlet weak var overviewLabel: UILabel!
    
    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let movie =  movie{
            titleLabel.text = movie.title as? String
           // releasedateLabel.text = movie.release_date as? String
            overviewLabel.text = movie.overview as? String
           // let backdropPathString = movie.backdrop_path as! String
            
            
           // let backdropURL = URL(string: baseURLString + backdropPathString)!
           // backDropImageView.af_setImage(withURL: backdropURL)
            
           // let posterURL = URL(string: baseURLString + posterPathString)!
            posterImageView.af_setImage(withURL: movie.posterUrl!)
            
            
            
            
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
