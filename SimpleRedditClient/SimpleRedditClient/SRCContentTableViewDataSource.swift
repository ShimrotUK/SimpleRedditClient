//
//  SRCContentTableViewDataSource.swift
//  SimpleRedditClient
//
//  Created by Eugen.Lysyuk on 9/30/18.
//  Copyright © 2018 SRC. All rights reserved.
//

import UIKit

class SRCContentTableViewDataSource: NSObject, UITableViewDataSource, UITableViewDelegate
{
    private let cellIdentifier = "SRCArticleTableViewCell"
    private var dataPresenter : SRCModelDataPresentable
    private weak var cellsDelegate : SRCArticleTableViewCellDelegate?

    init(with dataPresenter:SRCModelDataPresentable, cellsDelegate: SRCArticleTableViewCellDelegate)
    {
        self.dataPresenter = dataPresenter
        self.cellsDelegate = cellsDelegate
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.dataPresenter.currentEntities.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell : SRCArticleTableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? SRCArticleTableViewCell

        let articleEntity = self.dataPresenter.currentEntities[indexPath.row]
        cell!.articleID = articleEntity.ID
        cell!.titleLabel.text = articleEntity.title
        cell!.authorLabel.text = articleEntity.author
        cell!.dateLabel.text = articleEntity.date
        cell!.commentsCountLabel.text = articleEntity.numberOfComments
        cell!.thumbnailImageView.image = nil
        cell!.additionalImageURL = articleEntity.additionalImage
        cell!.delegate = self.cellsDelegate

        articleEntity.thumbnailGetterClosure!({(image: UIImage?, ID:String)->Void in
            if ID == cell!.articleID
            {
                if let theImage = image
                {
                    cell!.thumbnailImageView.image = theImage
                }
                else
                {
                    cell!.thumbnailImageView.image = UIImage(named: "NoThumbnail")
                }
            }
        })

        return cell!
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        let lableWidth = tableView.frame.width - 65.0
        let articleEntity = self.dataPresenter.currentEntities[indexPath.row]

        let minCellHeight = 50.0 as CGFloat
        var cellHeight = 25.0 as CGFloat

        let titleFont = UIFont.boldSystemFont(ofSize: 18.0)
        let otherLabelFont = UIFont.systemFont(ofSize: 14.0)

        cellHeight += self.heigth(for: articleEntity.title, fixedWidth: lableWidth, font: titleFont)
        cellHeight += self.heigth(for: articleEntity.author, fixedWidth: lableWidth, font: otherLabelFont)
        cellHeight += self.heigth(for: articleEntity.numberOfComments, fixedWidth: lableWidth, font: otherLabelFont)
        cellHeight += self.heigth(for: articleEntity.date, fixedWidth: lableWidth, font: otherLabelFont)

        return CGFloat.maximum(cellHeight, minCellHeight)
    }

    private func heigth(for text: String, fixedWidth: CGFloat, font:UIFont) -> CGFloat
    {
        let textAttributes = [NSAttributedStringKey.font: font]
        let textRect = text.boundingRect(with: CGSize(width:fixedWidth, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, attributes: textAttributes, context: nil)

        return textRect.size.height
    }
}
