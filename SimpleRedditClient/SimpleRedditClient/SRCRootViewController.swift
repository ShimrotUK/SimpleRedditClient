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
    var presenter = SRCModelDataPresenter(with: SRCRedditThumbnailRequestController())
    var tableViewDataSource : SRCContentTableViewDataSource?

    var observingID: UUID?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableViewDataSource = SRCContentTableViewDataSource(with: self.presenter)
        self.contentTableView.delegate = self.tableViewDataSource
        self.contentTableView.dataSource = self.tableViewDataSource
        self.observingID = self.provider.addObservingChanges(onChange: { (provider: SRCDataProvider) in
            switch provider.state
            {
                case .failWithError:
                    let alertController = UIAlertController.init(title: "Error occured", message: provider.error?.localizedDescription, preferredStyle: .alert)
                    self.present(alertController, animated: true, completion: nil)

                case .ready:
                    self.presenter.update(with: provider.articles!)
                    self.contentTableView.reloadData()
                default:
                break
            }
        })
        self.provider.requestFirst()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func newContentViewTapped(_ gestureRecognizer: UITapGestureRecognizer)
    {
        provider.requestFirst()
    }

    @IBAction func contentViewSwapedLeft(_ gestureRecognizer: UISwipeGestureRecognizer)
    {
        provider.requestNext()
    }

    @IBAction func contentViewSwapedRight(_ gestureRecognizer: UISwipeGestureRecognizer)
    {
        provider.requestPrevious()
    }
}

