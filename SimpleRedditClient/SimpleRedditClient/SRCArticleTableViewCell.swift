//
//  SRCArticleCellTableViewCell.swift
//  SimpleRedditClient
//
//  Created by Eugen.Lysyuk on 9/30/18.
//  Copyright © 2018 SRC. All rights reserved.
//

import UIKit

class SRCArticleTableViewCell: UITableViewCell
{

    @IBOutlet private(set) weak var thumbnailImageView: UIImageView!
    @IBOutlet private(set) weak var titleLabel: UILabel!
    @IBOutlet private(set) weak var authorLabel: UILabel!
    @IBOutlet private(set) weak var commentsCountLabel: UILabel!
    @IBOutlet private(set) weak var dateLabel: UILabel!
    var articleID: String? = nil
    var additionalImageURL: URL? = nil
    
}
