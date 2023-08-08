//
//  HomeViewController.swift
//  iOS-Exam
//
//  Created by Bryan Posas on 8/7/23.
//

import UIKit
import Bond

class HomeViewController: BaseViewController {
    private var viewModel: HomeViewModel!
    
    @IBOutlet weak var tblView: UITableView!
    
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bootstrap()
    }
    
    func injectViewModel(_ viewModel: HomeViewModel) {
        self.viewModel = viewModel
        
        _ = viewModel.movieResult.receive(on: DispatchQueue.main).observeNext(with: { movieResult in
            if movieResult != nil {
                self.tblView.reloadData()
            }
        })
        
        refreshMovies()
    }

    // MARK: Button actions
    @IBAction func btnMovies(_ sender: UIButton) {
        guard !sender.isSelected else { return }
        sender.isSelected = true
        
        self.title = "Movies"
        
        refreshMovies()
    }
    
    @IBAction func btnSeries(_ sender: UIButton) {
        guard !sender.isSelected else { return }
        sender.isSelected = true
        self.title = "Series"
    }
    
    @IBAction func btnEpisodes(_ sender: UIButton) {
        guard !sender.isSelected else { return }
        sender.isSelected = true
        self.title = "Episodes"
    }
    
    // MARK: Private Methods
    private func bootstrap() {
        tblView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshControlAction), for: .valueChanged)
        
        tblView.register(MovieCell.self, forCellReuseIdentifier: "MovieCellIdentifier")
    }
    
    @objc private func refreshControlAction() {
        refreshMovies()
    }
    
    private func refreshMovies() {
        viewModel.getMovies()
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movies().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movieCell = tableView.dequeueReusableCell(withIdentifier: "MovieCellIdentifier", for: indexPath) as! MovieCell
        let movie = viewModel.movies()[indexPath.row]
        movieCell.setup(withPosterImageUri: movie.poster_path, title: movie.title, releaseDate: movie.release_date, rating: movie.vote_average, overview: movie.overview)
        
        return movieCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        viewModel.goToVc(vc: )
    }
}
