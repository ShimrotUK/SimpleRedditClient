//
//  SRCResponseDataTransformerTest.swift
//  SimpleRedditClientTests
//
//  Created by Eugen.Lysyuk on 9/29/18.
//  Copyright © 2018 SRC. All rights reserved.
//

import XCTest

class SRCResponseDataTransformerTest: XCTestCase {

    
    func testCreation()
    {
        //! Arrange & Act
        let testedTransformer = SRCResponseDataTransformer()
        //! Assert
        XCTAssertNotNil(testedTransformer)
    }
    
    func testTransformCorrectJSON()
    {
        //! Arrange
        let stubbedJSONData = "{\"kind\": \"Listing\", \"data\": {\"modhash\": \"\", \"dist\": 1, \"children\": [{\"kind\": \"t3\", \"data\": {\"approved_at_utc\": null, \"subreddit\": \"funny\", \"selftext\": \"\", \"author_fullname\": \"t2_tu7hd\", \"saved\": false, \"mod_reason_title\": null, \"gilded\": 13, \"clicked\": false, \"title\": \"Guardians of the Front Page\", \"link_flair_richtext\": [], \"subreddit_name_prefixed\": \"r/funny\", \"hidden\": false, \"pwls\": 6, \"link_flair_css_class\": \"\", \"downs\": 0, \"thumbnail_height\": 58, \"hide_score\": false, \"name\": \"t3_5gn8ru\", \"quarantine\": false, \"link_flair_text_color\": \"dark\", \"author_flair_background_color\": null, \"subreddit_type\": \"public\", \"ups\": 283484, \"domain\": \"i.imgur.com\", \"media_embed\": {}, \"thumbnail_width\": 140, \"author_flair_template_id\": null, \"is_original_content\": false, \"user_reports\": [], \"secure_media\": null, \"is_reddit_media_domain\": false, \"is_meta\": false, \"category\": null, \"secure_media_embed\": {}, \"link_flair_text\": \"Best of 2016 Winner\", \"can_mod_post\": false, \"score\": 283484, \"approved_by\": null, \"thumbnail\": \"https://b.thumbs.redditmedia.com/yeLMMXr9vghtaz26xZ1A_PCg-vk4_KjtnHNlQ-NzkxA.jpg\", \"edited\": false, \"author_flair_css_class\": null, \"author_flair_richtext\": [], \"gildings\": {\"gid_1\": 0, \"gid_2\": 13, \"gid_3\": 0}, \"post_hint\": \"link\", \"content_categories\": null, \"is_self\": false, \"mod_note\": null, \"created\": 1480988474.0, \"link_flair_type\": \"text\", \"wls\": 6, \"banned_by\": null, \"author_flair_type\": \"text\", \"contest_mode\": false, \"selftext_html\": null, \"likes\": null, \"suggested_sort\": null, \"banned_at_utc\": null, \"view_count\": null, \"archived\": true, \"no_follow\": false, \"is_crosspostable\": false, \"pinned\": false, \"over_18\": false, \"preview\": {\"images\": [{\"source\": {\"url\": \"https://i.redditmedia.com/jzU2DNeq7eTA_cpq4H6Z7Sd5atiVA1JyUx7KwcIJ8N4.jpg?s=e127a2026430e0084080b817723ed23d\", \"width\": 890, \"height\": 370}, \"resolutions\": [{\"url\": \"https://i.redditmedia.com/jzU2DNeq7eTA_cpq4H6Z7Sd5atiVA1JyUx7KwcIJ8N4.jpg?fit=crop&amp;crop=faces%2Centropy&amp;arh=2&amp;w=108&amp;s=b58958a1c6f3389eb9d9d9bef0e6b2d0\", \"width\": 108, \"height\": 44}, {\"url\": \"https://i.redditmedia.com/jzU2DNeq7eTA_cpq4H6Z7Sd5atiVA1JyUx7KwcIJ8N4.jpg?fit=crop&amp;crop=faces%2Centropy&amp;arh=2&amp;w=216&amp;s=4a702071331b023f7625b074f3095b70\", \"width\": 216, \"height\": 89}, {\"url\": \"https://i.redditmedia.com/jzU2DNeq7eTA_cpq4H6Z7Sd5atiVA1JyUx7KwcIJ8N4.jpg?fit=crop&amp;crop=faces%2Centropy&amp;arh=2&amp;w=320&amp;s=4678fea2b4a1d4c43fc4296a08ecb945\", \"width\": 320, \"height\": 133}, {\"url\": \"https://i.redditmedia.com/jzU2DNeq7eTA_cpq4H6Z7Sd5atiVA1JyUx7KwcIJ8N4.jpg?fit=crop&amp;crop=faces%2Centropy&amp;arh=2&amp;w=640&amp;s=c0e4e8503451b2d6971d7a8feac8e463\", \"width\": 640, \"height\": 266}], \"variants\": {}, \"id\": \"y2rlIOoU9df4PrvL34ZKpC4hLj-hHtvIubIxqP0s8Zg\"}], \"reddit_video_preview\": {\"fallback_url\": \"https://v.redd.it/8kmykgwf1wn11/DASH_1_2_M\", \"height\": 266, \"width\": 640, \"scrubber_media_url\": \"https://v.redd.it/8kmykgwf1wn11/DASH_600_K\", \"dash_url\": \"https://v.redd.it/8kmykgwf1wn11/DASHPlaylist.mpd\", \"duration\": 36, \"hls_url\": \"https://v.redd.it/8kmykgwf1wn11/HLSPlaylist.m3u8\", \"is_gif\": true, \"transcoding_status\": \"completed\"}, \"enabled\": false}, \"media_only\": false, \"link_flair_template_id\": null, \"can_gild\": false, \"spoiler\": false, \"locked\": false, \"author_flair_text\": null, \"visited\": false, \"num_reports\": null, \"distinguished\": null, \"subreddit_id\": \"t5_2qh33\", \"mod_reason_by\": null, \"removal_reason\": null, \"link_flair_background_color\": \"\", \"id\": \"5gn8ru\", \"report_reasons\": null, \"author\": \"iH8myPP\", \"num_crossposts\": 35, \"num_comments\": 5047, \"send_replies\": true, \"whitelist_status\": \"all_ads\", \"mod_reports\": [], \"author_flair_text_color\": null, \"permalink\": \"/r/funny/comments/5gn8ru/guardians_of_the_front_page/\", \"parent_whitelist_status\": \"all_ads\", \"stickied\": false, \"url\": \"http://i.imgur.com/OOFRJvr.gifv\", \"subreddit_subscribers\": 20856937, \"created_utc\": 1480959674.0, \"media\": null, \"is_video\": false}}], \"after\": \"t3_5gn8ru\", \"before\": null}}".data(using: .utf8)
        let testedTransformer = SRCResponseDataTransformer()
        //! Act
        do {
            let entities = try testedTransformer.transform(JSONData: stubbedJSONData!)
            //! Assert
            XCTAssertNotNil(entities)
            XCTAssertEqual(1, entities.count)
            let entity = entities.first!
            XCTAssertEqual("t3_5gn8ru", entity.name)
            XCTAssertEqual("Guardians of the Front Page", entity.title)
            XCTAssertEqual("iH8myPP", entity.author)
            XCTAssertEqual(1480988474.0, entity.created)
            XCTAssertEqual(URL(string: "https://b.thumbs.redditmedia.com/yeLMMXr9vghtaz26xZ1A_PCg-vk4_KjtnHNlQ-NzkxA.jpg"),
                           entity.thumbnail)
            XCTAssertEqual(5047, entity.commentsCount)
            XCTAssertEqual(URL(string: "https://i.redditmedia.com/jzU2DNeq7eTA_cpq4H6Z7Sd5atiVA1JyUx7KwcIJ8N4.jpg?s=e127a2026430e0084080b817723ed23d"), entity.additionalPicture!.images.first!.source.url)
        }
        catch
        {
            XCTAssert(false)
        }
    }

    func testTransformCorruptedJSON()
    {
        //! Arrange
        let stubbedJSONData = "{\"kind\": \"Listing\", \"data\": {\"modhash\": \"\", \"dist\": 1, \"children\": [{\"kind\": \"t3".data(using: .utf8)
        let testedTransformer = SRCResponseDataTransformer()
        //! Act
        do {
            _ = try testedTransformer.transform(JSONData: stubbedJSONData!)
            //! Assert
            XCTAssert(false)
        }
        catch
        {
            XCTAssertNotNil(error)
        }
    }
}
