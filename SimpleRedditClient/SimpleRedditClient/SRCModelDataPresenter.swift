//
//  SRCModelDataPresenter.swift
//  SimpleRedditClient
//
//  Created by Eugen.Lysyuk on 9/25/18.
//  Copyright © 2018 SRC. All rights reserved.
//

import UIKit

class SRCModelDataPresenter
{
    private let secondsInYear = 31556926.0
    private let secondsInMonth = 2629743.0
    private let secondsInWeek = 604800.0
    private let secondsInDay = 86400.0
    private let secondsInHour = 3600.0
    private let secondsInMinute = 60.0

    private(set) var currentArticleEntities = [SRCArticlePresentationEntity]()

    private(set) var thumbnailRequestController : SRCRedditThumbnailRequestController

    init(with thumbnailRequestController: SRCRedditThumbnailRequestController)
    {
        self.thumbnailRequestController = thumbnailRequestController
    }

    func update(with articleEntities:[SRCRedditArticleEntity])
    {
        self.currentArticleEntities.removeAll()
        let currentTimeInterval = Date().timeIntervalSince1970

        for articleEntity in articleEntities
        {
            let numberOfComments = self.transform(commentsCount: articleEntity.commentsCount)
            let date = self.transform(timeInterval: currentTimeInterval, beforeInterval: articleEntity.created)
            let thumbnailGetterClosure = articleEntity.thumbnail != nil ? {(_ imageDeliveryClosure: @escaping (_ image: UIImage?, _ articleEntityID: String) -> Void) -> Void in
                self.thumbnailRequestController.sendThumbnailRequest(with: articleEntity.thumbnail!, completion: { (image:UIImage?) in
                    OperationQueue.main.addOperation {
                        imageDeliveryClosure(image, articleEntity.name)
                    }
                })
                }
                : nil
            let currentEntity = SRCArticlePresentationEntity(with:articleEntity.name, title: articleEntity.title, author: articleEntity.author, date: date,
                                                 thumbnailGetterClosure: thumbnailGetterClosure, numberOfComments: numberOfComments, additionalImage: articleEntity.additionalPicture?.images.first?.source.url)
            self.currentArticleEntities.append(currentEntity)
        }
    }

    private func transform(timeInterval: TimeInterval, beforeInterval:TimeInterval) -> String
    {
        var result : String

        let timeDelta = timeInterval - beforeInterval

        let numberOfYears = Int(timeDelta / secondsInYear)

        repeat {

            if numberOfYears >= 2
            {
                result = "submited \(numberOfYears) years ago"
                break
            }
            else if numberOfYears == 1
            {
                result = "submited \(numberOfYears) year ago"
                break
            }

            let numberOfMonths = Int(timeDelta / secondsInMonth)

            if numberOfMonths >= 2
            {
                result = "submited \(numberOfMonths) months ago"
                break
            }
            else if numberOfMonths == 1
            {
                result = "submited \(numberOfMonths) month ago"
                break
            }

            let numberOfWeeks = Int(timeDelta / secondsInWeek)

            if numberOfWeeks >= 2
            {
                result = "submited \(numberOfWeeks) weeks ago"
                break
            }
            else if numberOfWeeks == 1
            {
                result = "submited \(numberOfWeeks) week ago"
                break
            }

            let numberOfDays = Int(timeDelta / secondsInDay)

            if numberOfDays >= 2
            {
                result = "submited \(numberOfDays) days ago"
                break
            }
            else if numberOfDays == 1
            {
                result = "submited \(numberOfDays) day ago"
                break
            }

            let numberOfHours = Int(timeDelta / secondsInHour)

            if numberOfHours >= 2
            {
                result = "submited \(numberOfHours) hours ago"
                break
            }
            else if numberOfHours == 1
            {
                result = "submited \(numberOfHours) hour ago"
                break
            }

            let numberOfMinutes = Int(timeDelta / secondsInMinute)

            if numberOfMinutes >= 2
            {
                result = "submited \(numberOfMinutes) minutes ago"
                break
            }
            else if numberOfMinutes == 1
            {
                result = "submited \(numberOfMinutes) minute ago"
                break
            }
            else if timeDelta >= 2
            {
                result = "submited \(timeDelta) seconds ago"
                break
            }
            else
            {
                result = "submited just now"
                break
            }

        } while false

        return result
    }

    private func transform(commentsCount: Int) -> String
    {
        var result : String

        if commentsCount >= 2
        {
            result = "\(commentsCount) comments"
        }
        else if commentsCount == 1
        {
            result = "\(commentsCount) comment"
        }
        else
        {
            result = "No comments"
        }

        return result
    }
}

extension SRCModelDataPresenter : SRCModelDataPresentable
{
    var currentEntities: [SRCArticlePresentationEntity] {
        return self.currentArticleEntities
    }
}
