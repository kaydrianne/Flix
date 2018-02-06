//
//  NowPlayingViewController.swift
//  Flix
//
//  Created by TiAuna Dodd on 2/4/18.
//  Copyright © 2018 TiAuna Dodd. All rights reserved.
//

import UIKit
import AlamofireImage


class NowPlayingViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  
    @IBOutlet weak var tableView: UITableView!
    
    var movies: [[String: Any]] = []
    var refreshControl: UIRefreshControl!
    
   @objc override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl = UIRefreshControl()
        //instantiates an instance of refresh being pulled
        refreshControl.addTarget(self, action: #selector (NowPlayingViewController.didPullToRefresh(_:)), for:.valueChanged)
    tableView.insertSubview(refreshControl, at: 0)
    
        tableView.dataSource = self
        tableView.rowHeight = 150
        activityIndicator.startAnimating()    // Start the activity indicator

        fetchMovies()
    
      //  let alertController = UIAlertController(title: "Title", message: "Message", preferredStyle: .alert) //Create the alert controller for internet errot
        
    }
    
    //tells if refresh is being pulled or not
    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl)
    {
        fetchMovies()
    }
    
    func fetchMovies() {
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=fd8c81a8e62c3aa9e4e0939bbdb2fd68")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            //This will run when the network request returns
            if let error = error{
                print(error.localizedDescription)
                
                let alertController = UIAlertController(title: "Error", message: "No Internet Connection", preferredStyle: .alert) //Create the alert controller for internet errot
               // alertController.
                
                let OKAction = UIAlertAction(title: "Try Again", style: .default) { (action) in
                    // handle response here.
                    self.fetchMovies()
                }
                // add the OK action to the alert controller
                alertController.addAction(OKAction)
                self.present(alertController, animated: true)
                
                
                
                
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                // print(dataDictionary)
                let movies = dataDictionary["results"] as![[String: Any]]
                self.movies = movies
                
                self.activityIndicator.stopAnimating()   // Stop the activity indicator;Hides automatically if "Hides When Stopped" is enabled
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
        task.resume()
        
        
    }
    
    //tell how many cells
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movies.count
    }
       //whta the cell is gonna be
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        
        
        let movie = movies[indexPath.row]
        let title = movie["title"] as! String
        let overview = movie["overview"] as! String
        
        cell.titleLabel.text = title
        cell.overviewLabel.text = overview
       
        //to get full path to poster image
        let posterPathString = movie["poster_path"] as! String
        //base url
        let baseURLString = "https://image.tmdb.org/t/p/w500"
        
        let posterURL = URL(string: baseURLString + posterPathString)!
        cell.posterImageView.af_setImage(withURL: posterURL)
    
        return cell
    }
}





