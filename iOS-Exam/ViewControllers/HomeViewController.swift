//
//  HomeViewController.swift
//  iOS-Exam
//
//  Created by Bryan Posas on 8/7/23.
//

import UIKit
import Bond

class HomeViewController: UIViewController {
    @IBOutlet weak var tblView: UITableView!
    private var viewModel: HomeViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        bootstrap()
    }
    
    func injectViewModel(_ viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }

    // MARK: Button actions
    @IBAction func btnMovies(_ sender: UIButton) {
        self.title = "Movies"
        
        viewModel.getMovies()
        
        sender.isSelected = true
        
    }
    
    @IBAction func btnSeries(_ sender: UIButton) {
        self.title = "Series"
    }
    
    @IBAction func btnEpisodes(_ sender: UIButton) {
        self.title = "Episodes"
    }
    
    // MARK: Private Methods
    private func bootstrap() {
        viewModel.getMovies()
        
        _ = viewModel.movieResult.receive(on: DispatchQueue.main).observeNext(with: { movieResult in
            if movieResult != nil {
                self.tblView.reloadData()
            }
        })
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
