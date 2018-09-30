//
//  SRCModelDataPresentable.swift
//  SimpleRedditClient
//
//  Created by Eugen.Lysyuk on 9/25/18.
//  Copyright © 2018 SRC. All rights reserved.
//

import Foundation

protocol SRCModelDataPresentable
{
    var currentEntities : [SRCArticlePresentationEntity] {get}
}
