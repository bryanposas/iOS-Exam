//
//  HomeViewModel.swift
//  iOS-Exam
//
//  Created by Bryan Posas on 8/7/23.
//

import Foundation
import Bond

class BaseViewModel: NSObject {
    weak var coordinator: CoordinatorProtocol?
    
    init(coordinator: CoordinatorProtocol) {
        self.coordinator = coordinator
    }
}

class HomeViewModel: BaseViewModel {
    let omdbData: OmdbDataProtocol
    var tblViewDataSource: UITableViewDataSource?
    var tblViewDelegate: UITableViewDelegate?
    
    let movieResult = Observable<MovieResult?>(nil)
    
    init(with omdbData: OmdbDataProtocol, coordinator: CoordinatorProtocol) {
        self.omdbData = omdbData
        
        super.init(coordinator: coordinator)
    }
    
    func getMovies() {
        omdbData.getMovies { movieResult in
            self.movieResult.value = movieResult
        }
    }
}
