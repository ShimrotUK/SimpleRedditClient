//
//  SRCShowFullSizeImageViewController.swift
//  SimpleRedditClient
//
//  Created by Eugen.Lysyuk on 10/1/18.
//  Copyright © 2018 SRC. All rights reserved.
//

import UIKit

class SRCShowFullSizeImageViewController: UIViewController {

    var urlToOpen : URL?

    @IBOutlet private weak var contentWebView: UIWebView!

    override func viewDidLoad()
    {
        super.viewDidLoad()

        if let theURL = self.urlToOpen
        {
            self.contentWebView.loadRequest(URLRequest(url: theURL))
        }
    }

    @IBAction func backButtonTapped(_ sender: Any)
    {
        performSegue(withIdentifier: "SRCBackToRootViewController", sender: self)
    }
}
