//
//  HomeViewModel.swift
//  iOS-Exam
//
//  Created by Bryan Posas on 8/7/23.
//

import Foundation
import Bond

class HomeViewModel {
    let omdbData: OmdbDataProtocol
    var tblViewDataSource: UITableViewDataSource?
    var tblViewDelegate: UITableViewDelegate?
    
    let movieResult = Observable<MovieResult?>(nil)
    
    init(with omdbData: OmdbDataProtocol) {
        self.omdbData = omdbData
    }
    
    func getMovies() {
        omdbData.getMovies { movieResult in
            self.movieResult.value = movieResult
        }
    }
}
