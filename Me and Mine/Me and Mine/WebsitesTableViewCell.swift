//
//  WebsitesTableViewCell.swift
//  Me and Mine
//
//  Created by Tiara Imani Logan on 3/28/20.
//  Copyright © 2020 Logan. All rights reserved.
//

import UIKit

class WebsitesTableViewCell: UITableViewCell {
    
    


        @IBOutlet var movieTitleLabel: UILabel!
        @IBOutlet var movieYearLabel: UILabel!
        @IBOutlet var moviePosterImageView: UIImageView!

        override func awakeFromNib() {
            super.awakeFromNib()
        }

        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)
        }

        static let identifier = "WebsitesTableViewCell"

        static func nib() -> UINib {
            return UINib(nibName: "WebsitesTableViewCell",
                         bundle: nil)
        }

        func configure(with model: Websites) {
            self.movieTitleLabel.text = model.Title
            self.movieYearLabel.text = model.Year
            let url = model.Poster
            if let data = try? Data(contentsOf: URL(string: url)!) {
                self.moviePosterImageView.image = UIImage(data: data)
            }
        }
        
    }


