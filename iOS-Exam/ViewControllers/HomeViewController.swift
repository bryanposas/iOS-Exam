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
        
    }
    
    func injectViewModel(_ viewModel: HomeViewModel) {
        self.viewModel = viewModel
        
        bootstrap()
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
        _ = viewModel.movieResult.receive(on: DispatchQueue.main).observeNext(with: { movieResult in
            if movieResult != nil {
                self.tblView.reloadData()
            }
        })
        
        viewModel.getMovies()
        
        tblView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshControlAction), for: .valueChanged)
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
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
