//
//  NewsTableViewCell.swift
//  AppNews
//
//  Created by Hung Cao on 31/03/2021.
//

import UIKit
import Kingfisher

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var newsDescriptionLabel: UILabel!
    @IBOutlet weak var newsTimeLabel: UILabel!
    
    var article: Article? {
        didSet {
            setupUI()
        }
    }
    
    private func setupUI() {
        guard let article = article else {
            return
        }
        newsImageView.kf.setImage(with: URL(string: article.imageUrl ?? ""))
        newsTitleLabel.text = article.newsTitle
        newsDescriptionLabel.text = article.newsDescription
        newsTimeLabel.text = article.publishedAt?.toString()
    }
    
}
