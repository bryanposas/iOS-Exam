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
    
    func goToVc(vc: UIViewController, navigate: NavigationType = .Push, shouldAnimate: Bool = true) {
        coordinator?.goToVC(vc: vc, navigate: navigate, shouldAnimate: shouldAnimate)
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
    
    func movies() -> [Movie] {
        return movieResult.value?.movies?.array as? [Movie] ?? []
    }
    
    func getMovies() {
        omdbData.getMovies { movieResult in
            self.movieResult.value = movieResult
        }
    }
}
