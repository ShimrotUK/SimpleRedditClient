//
//  SRCArticleEntityStructureTest.swift
//  SimpleRedditClientTests
//
//  Created by Eugen.Lysyuk on 9/25/18.
//  Copyright © 2018 SRC. All rights reserved.
//

import XCTest

class SRCArticleEntityStructureTest: XCTestCase {

    
    func testExample() {

        //! Arrange
        let stubbedID = "ID"
        let stubbedTitle = "title"
        let stubbedAuthor = "author"
        let stubbedDate = "date"
        let stubbedThumbnail = URL(string:"https://thumbnail")
        let stubbedNumberOfcomments = "numberOfcomments"
        let stubbedAdditionalPicture = URL(string:"https://additionalPicture")

        //! Act
        let testedStructure = SRCArticleEntity(stubbedID, title: stubbedTitle, author: stubbedAuthor, date: stubbedDate,
                                               thumbnail: stubbedThumbnail, numberOfComments: stubbedNumberOfcomments,
                                               additionalImage: stubbedAdditionalPicture)

        //! Assert
        XCTAssertEqual(testedStructure.ID, stubbedID)
        XCTAssertEqual(testedStructure.title, stubbedTitle)
        XCTAssertEqual(testedStructure.author, stubbedAuthor)
        XCTAssertEqual(testedStructure.date, stubbedDate)
        XCTAssertEqual(testedStructure.thumbnail, stubbedThumbnail)
        XCTAssertEqual(testedStructure.numberOfComments, stubbedNumberOfcomments)
        XCTAssertEqual(testedStructure.additionalImage, stubbedAdditionalPicture)
    }
}
