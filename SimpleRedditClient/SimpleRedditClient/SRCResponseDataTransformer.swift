//
//  SRCResponseDataTransformer.swift
//  SimpleRedditClient
//
//  Created by Eugen.Lysyuk on 9/28/18.
//  Copyright © 2018 SRC. All rights reserved.
//

import Foundation

class SRCResponseDataTransformer {

    func transform(JSONData:Data) throws -> [SRCRedditArticleEntity]
    {
        let model = try JSONDecoder().decode(RedditTopListRoot.self, from:
            JSONData)

        return model.data.children.map({ (article: RedditTopListChild) -> SRCRedditArticleEntity in
            article.data
        })
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

struct SRCRedditArticleEntity : Codable
{
    var title : String
    var name : String
    var thumbnail : URL?
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

struct SRCRedditArticlePreview : Codable
{
    var images : [SRCRedditArticlePreviewImages]
}

struct SRCRedditArticlePreviewImages : Codable
{
    var source : SRCRedditArticlePreviewImageSource
}

struct SRCRedditArticlePreviewImageSource : Codable
{
    var url : URL
}
