//
//  SRCArticleEntityStructureTest.swift
//  SimpleRedditClientTests
//
//  Created by Eugen.Lysyuk on 9/25/18.
//  Copyright © 2018 SRC. All rights reserved.
//

import XCTest

class SRCArticlePresentationEntityTest: XCTestCase {

    
    func testExample() {

        //! Arrange
        var checkBool = false
        let stubbedID = "ID"
        let stubbedTitle = "title"
        let stubbedAuthor = "author"
        let stubbedDate = "date"
        let stubbedThumbnailClosure = {(_ imageDeliveryClosure: @escaping (_ image: UIImage?, _ articleEntityID: String) -> Void) -> Void in checkBool = true}
        let stubbedNumberOfcomments = "numberOfcomments"
        let stubbedAdditionalPicture = URL(string:"https://additionalPicture")

        //! Act
        let testedStructure = SRCArticlePresentationEntity(with:stubbedID, title: stubbedTitle,
                                                           author: stubbedAuthor, date: stubbedDate,
                                                           thumbnailGetterClosure: stubbedThumbnailClosure,
                                                           numberOfComments:stubbedNumberOfcomments,
                                                           additionalImage: stubbedAdditionalPicture)

        //! Assert
        XCTAssertEqual(testedStructure.ID, stubbedID)
        XCTAssertEqual(testedStructure.title, stubbedTitle)
        XCTAssertEqual(testedStructure.author, stubbedAuthor)
        XCTAssertEqual(testedStructure.date, stubbedDate)
        XCTAssertFalse(checkBool)
        testedStructure.thumbnailGetterClosure!({(image: UIImage?, ID: String) -> Void in})
        XCTAssertTrue(checkBool)
        XCTAssertEqual(testedStructure.numberOfComments, stubbedNumberOfcomments)
        XCTAssertEqual(testedStructure.additionalImage, stubbedAdditionalPicture)
    }
}
