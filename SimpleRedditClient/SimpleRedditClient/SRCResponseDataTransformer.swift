//
//  SRCResponseDataTransformer.swift
//  SimpleRedditClient
//
//  Created by Eugen.Lysyuk on 9/28/18.
//  Copyright © 2018 SRC. All rights reserved.
//

import Foundation

class SRCResponseDataTransformer {

    private let secondsInYear = 31556926.0
    private let secondsInMonth = 2629743.0
    private let secondsInWeek = 604800.0
    private let secondsInDay = 86400.0
    private let secondsInHour = 3600.0
    private let secondsInMinute = 60.0

    func transform(JSONData:Data) throws -> [SRCRedditArticleEntity]
    {
        let model = try JSONDecoder().decode(RedditTopListRoot.self, from:
            JSONData)
//        let currentTimeInterval = Date().timeIntervalSince1970
//
//
//        for topListChild in model.data.children
//        {
//            let childData = topListChild.data
//            let numberOfComments = self.transform(commentsCount: childData.commentsCount)
//            let date = self.transform(timeInterval: currentTimeInterval, beforeInterval: childData.created)
//            let currentEntity = SRCArticleEntity(childData.name, title: childData.title, author: childData.author, date: date,
//                                                 thumbnail: childData.thumbnail, numberOfComments: numberOfComments, additionalImage: childData.additionalPicture)
//            result.append(currentEntity)
//        }

        return model.data.children.map({ (article: RedditTopListChild) -> SRCRedditArticleEntity in
            article.data
        })
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

fileprivate struct RedditTopListRoot : Decodable
{
    var data : RedditTopListData
}

fileprivate struct RedditTopListData : Decodable
{
    var children : [RedditTopListChild]
}

fileprivate struct RedditTopListChild : Decodable
{
    var data : SRCRedditArticleEntity
}

struct SRCRedditArticleEntity : Decodable
{
    var title : String
    var name : String
    var thumbnail : URL
    var additionalPicture : SRCRedditArticlePreview?
    var author : String
    var created : Double
    var commentsCount : Int


    enum CodingKeys : String, CodingKey {
        case title
        case name
        case thumbnail
        case additionalPicture = "preview"
        case author
        case created
        case commentsCount = "num_comments"
    }
}

struct SRCRedditArticlePreview : Decodable
{
    var images : [SRCRedditArticlePreviewImages]
}

struct SRCRedditArticlePreviewImages : Decodable
{
    var source : SRCRedditArticlePreviewImageSource
}

struct SRCRedditArticlePreviewImageSource : Decodable
{
    var url : URL
}
