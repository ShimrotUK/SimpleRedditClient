//
//  SRCNotificationView.swift
//  SimpleRedditClient
//
//  Created by Eugen.Lysyuk on 10/1/18.
//  Copyright © 2018 SRC. All rights reserved.
//

import UIKit

class SRCNotificationView: UIView {

    private let copyingText = "Saving picture to foto library"
    private let successText = "Picture successful saved to foto library"
    @IBOutlet private weak var notificationText: UILabel!
    @IBOutlet private weak var notificationProgress: UIActivityIndicatorView!
    @IBOutlet private var notificationProgressToTextConstraint: NSLayoutConstraint!

    func switchToCopying()
    {
        self.notificationProgress.isHidden = false
        self.notificationProgress.startAnimating()
        self.notificationText.text = copyingText
        self.notificationProgressToTextConstraint.isActive = true
    }

    func switchToSuccess()
    {
        self.notificationProgress.isHidden = true
        self.notificationProgress.stopAnimating()
        self.notificationText.text = successText
        self.notificationProgressToTextConstraint.isActive = false
    }
}
