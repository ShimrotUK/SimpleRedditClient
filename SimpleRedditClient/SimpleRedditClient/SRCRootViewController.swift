//
//  ViewController.swift
//  SimpleRedditClient
//
//  Created by Eugen.Lysyuk on 9/25/18.
//  Copyright © 2018 SRC. All rights reserved.
//

import UIKit

class SRCRootViewController: UIViewController, SRCArticleTableViewCellDelegate {

    @IBOutlet private weak var progressNotificationView: SRCNotificationView!
    @IBOutlet private weak var contentTableView: UITableView!
    @IBOutlet private var showNotificationConstraint: NSLayoutConstraint!
    var provider = SRCDataProvider(SRCRedditRequestController(), dataTranformer: SRCResponseDataTransformer())
    var presenter = SRCModelDataPresenter(with: SRCRedditThumbnailRequestController())
    var tableViewDataSource : SRCContentTableViewDataSource?

    var observingID: UUID?

    deinit {
        if let theObservingID = observingID
        {
            self.provider.removeObservingChanges(theObservingID)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.showNotificationConstraint.isActive = true
        self.tableViewDataSource = SRCContentTableViewDataSource(with: self.presenter, cellsDelegate: self)
        self.contentTableView.delegate = self.tableViewDataSource
        self.contentTableView.dataSource = self.tableViewDataSource
        self.observingID = self.provider.addObservingChanges(onChange: { (provider: SRCDataProvider) in
            switch provider.state
            {
                case .failWithError:
                    let alertController = UIAlertController(title: "Error occured", message: provider.error?.localizedDescription, preferredStyle: .alert)
                    let alertAction = UIAlertAction.init(title: "OK", style: UIAlertActionStyle.default, handler: { (action:UIAlertAction) in
                        self.dismiss(animated: true, completion: nil)
                    })
                    alertController.addAction(alertAction)

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

    //! Actions

    @IBAction func newContentViewTapped(_ gestureRecognizer: UITapGestureRecognizer)
    {
        self.provider.requestFirst()
        self.showNotificationConstraint.isActive = true
    }

    @IBAction func contentViewSwapedLeft(_ gestureRecognizer: UISwipeGestureRecognizer)
    {
        self.provider.requestNext()

        if self.provider.currnetPage > 4
        {
            self.showNotificationConstraint.isActive = false
        }
    }

    @IBAction func contentViewSwapedRight(_ gestureRecognizer: UISwipeGestureRecognizer)
    {
        self.provider.requestPrevious()
        if self.provider.currnetPage == 1
        {
            self.showNotificationConstraint.isActive = true
        }
    }

    //! SRCArticleTableViewCellDelegate

    func receivedTap(onImageAt url: URL)
    {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let alertActionOpen = UIAlertAction.init(title: "Open full size", style: UIAlertActionStyle.default, handler: { (action:UIAlertAction) in
            self.dismiss(animated: true, completion: nil)
        })
        let alertActionOpenInSafary = UIAlertAction.init(title: "Open full size in safary", style: UIAlertActionStyle.default, handler: { (action:UIAlertAction) in
            self.dismiss(animated: true, completion: nil)
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        })
        let alertActionSave = UIAlertAction.init(title: "Save to foto", style: UIAlertActionStyle.destructive, handler: { (action:UIAlertAction) in

            self.progressNotificationView.switchToCopying()
            self.progressNotificationView.isHidden = false
            let requestController = SRCRedditThumbnailRequestController()
            requestController.sendThumbnailRequest(with: url, completion: { (image: UIImage?) in
                if let theImage = image
                {
                    OperationQueue.main.addOperation {
                        UIImageWriteToSavedPhotosAlbum(theImage, nil, nil, nil)
                        self.progressNotificationView.switchToSuccess()
                        let deadlineTime = DispatchTime.now() + .seconds(1)
                        DispatchQueue.main.asyncAfter(deadline: deadlineTime, execute: {
                            self.progressNotificationView.isHidden = true
                        })
                    }
                }
            })

            self.dismiss(animated: true, completion: nil)
        })
        let alertActionCancel = UIAlertAction.init(title: "Cancel", style: UIAlertActionStyle.cancel, handler: { (action:UIAlertAction) in
            self.dismiss(animated: true, completion: nil)
        })
        alertController.addAction(alertActionOpen)
        alertController.addAction(alertActionOpenInSafary)
        alertController.addAction(alertActionSave)
        alertController.addAction(alertActionCancel)

        self.present(alertController, animated: true, completion: nil)
    }
}

