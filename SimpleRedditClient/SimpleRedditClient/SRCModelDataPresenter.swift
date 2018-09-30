//
//  SRCModelDataPresenter.swift
//  SimpleRedditClient
//
//  Created by Eugen.Lysyuk on 9/25/18.
//  Copyright © 2018 SRC. All rights reserved.
//

import Foundation

class SRCModelDataPresenter
{
    func update(with articleEntities:[SRCRedditArticleEntity])
    {
        
    }

}

extension SRCModelDataPresenter : SRCModelDataPresentable
{
    var currentEntities: [SRCArticleEntity] {
        return self.currentEntities
    }
}
