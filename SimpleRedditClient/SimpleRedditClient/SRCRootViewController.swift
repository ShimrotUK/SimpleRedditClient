//
//  ViewController.swift
//  SimpleRedditClient
//
//  Created by Eugen.Lysyuk on 9/25/18.
//  Copyright © 2018 SRC. All rights reserved.
//

import UIKit

class SRCRootViewController: UIViewController {

    @IBOutlet private weak var contentTableView: UITableView!
    @IBOutlet private weak var newContentNotificationView: UIView!
    @IBOutlet private var showNotificationConstraint: NSLayoutConstraint!
    var provider = SRCDataProvider(SRCRedditRequestController(), dataTranformer: SRCResponseDataTransformer())

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func newContentViewTapped(_ gestureRecognizer: UITapGestureRecognizer)
    {
        provider.requestFirst()
        provider.requestFirst()
    }
}

