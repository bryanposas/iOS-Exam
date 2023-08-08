//
//  MovieCell.swift
//  iOS-Exam
//
//  Created by Bryan Posas on 8/7/23.
//

import UIKit
import StarReview
import Kingfisher

class MovieCell: UITableViewCell {
    @IBOutlet weak var imgPoster: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblReleaseDate: UILabel!
    @IBOutlet weak var viewRatingPlaceholder: StarReview!
    @IBOutlet weak var lblOverview: UILabel!
    
    func setup(withPosterImageUri posterImageUri: String?, title: String?, releaseDate: String?, rating: Double, overview: String?) {
        self.imgPoster.kf.setImage(with: URL(string: "\(Constants.tmdbImageBaseUrl)\(posterImageUri)"))
        
        self.lblTitle.text = title
        self.lblReleaseDate.text = releaseDate
        self.lblOverview.text = overview
        
        self.viewRatingPlaceholder.starFillColor = UIColor.yellow
        self.viewRatingPlaceholder.starBackgroundColor = UIColor.lightGray
        self.viewRatingPlaceholder.allowEdit = false
        self.viewRatingPlaceholder.allowAccruteStars = true
        self.viewRatingPlaceholder.starCount = 10
        self.viewRatingPlaceholder.value = Float(rating)
        
        
    }
}
