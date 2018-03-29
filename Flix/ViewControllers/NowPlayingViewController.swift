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
    
    var movies: [Movie] = []
    var refreshControl: UIRefreshControl!
    
   @objc override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl = UIRefreshControl()
        //instantiates an instance of refresh being pulled
        refreshControl.addTarget(self, action: #selector (NowPlayingViewController.didPullToRefresh(_:)), for:.valueChanged)
    tableView.insertSubview(refreshControl, at: 0)
    
        tableView.dataSource = self
        tableView.rowHeight = 170
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
        MovieApiManager().nowPlayingMovies { (movies: [Movie]?, error: Error?) in
            if let error = error {
                let alertController = UIAlertController(title: "Error", message: "No Internet Connection", preferredStyle: .alert) //Create the alert controller for internet errot
                // alertController.
                
                let OKAction = UIAlertAction(title: "Try Again", style: .default) { (action) in
                    // handle response here.
                    self.fetchMovies()
                }
                // add the OK action to the alert controller
                alertController.addAction(OKAction)
                self.present(alertController, animated: true)
            }

            if let movies = movies {
                self.movies = movies
                self.tableView.reloadData()
                self.activityIndicator.stopAnimating()   // Stop the activity indicator;Hides automatically if "Hides When
                self.refreshControl.endRefreshing()
            }
        }
    }
    
    //tell how many cells
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movies.count
    }
       //whta the cell is gonna be
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        
        
        let movie = movies[indexPath.row] // [String: Any] -> [Movie]
//        let title = movie["title"] as! String //
        cell.titleLabel.text = movie.title
        cell.overviewLabel.text = movie.overview
       
        //to get full path to poster image
        cell.posterImageView.af_setImage(withURL: movie.posterUrl!)
    
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        if let indexPath = tableView.indexPath(for: cell){
            let movie = movies[indexPath.row]
            let detailViewConroller = segue.destination as! DetailViewController
            detailViewConroller.movie = movie
        }
        
        
    }
}





