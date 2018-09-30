//
//  SRCArticleEntity.swift
//  SimpleRedditClient
//
//  Created by Eugen.Lysyuk on 9/25/18.
//  Copyright © 2018 SRC. All rights reserved.
//

import UIKit

struct SRCArticleEntity {

    typealias SRCThumbnailGetterClosure = ((_ imageDeliveryClosure: (_ image: UIImage, _ articleEntityID: String) -> Void) -> Void)

    let ID : String
    let title : String
    let author : String
    let date : String
    let numberOfComments : String
    let thumbnailGetterClosure : SRCThumbnailGetterClosure?
    let additionalImage : URL?

    init(_ ID:String, title: String, author: String, date: String, thumbnailGetterClosure: SRCThumbnailGetterClosure?, numberOfComments:String, additionalImage: URL?)
    {
        self.ID = ID
        self.title = title
        self.author = author
        self.date = date
        self.thumbnailGetterClosure = thumbnailGetterClosure
        self.numberOfComments = numberOfComments
        self.additionalImage = additionalImage
    }
}
