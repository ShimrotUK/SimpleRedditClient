//
//  ViewController.swift
//  SimpleRedditClient
//
//  Created by Eugen.Lysyuk on 9/25/18.
//  Copyright © 2018 SRC. All rights reserved.
//

import UIKit

class SRCRootViewController: UIViewController, SRCArticleTableViewCellDelegate {

    private let hasAlreadyLaunchedKey = "HasAlredyLaunched"
    private let restorableDataKey = "RestorableDataKey"
    private var fullSizeURL : URL?
    @IBOutlet private weak var progressNotificationView: SRCNotificationView!
    @IBOutlet private weak var contentTableView: UITableView!
    @IBOutlet private var hideNotificationConstraint: NSLayoutConstraint!
    private(set) var provider = SRCDataProvider(SRCRedditRequestController(), dataTranformer: SRCResponseDataTransformer()) {
        willSet
        {
            if let theObservingID = observingID
            {
                provider.removeObservingChanges(theObservingID)
            }
        }
    }
    private(set) var presenter = SRCModelDataPresenter(with: SRCRedditThumbnailRequestController())
    private(set) var tableViewDataSource : SRCContentTableViewDataSource?

    private(set) var observingID: UUID?

    deinit {
        if let theObservingID = observingID
        {
            self.provider.removeObservingChanges(theObservingID)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.initialize()
    }

    private func initialize()
    {
        self.hideNotificationConstraint.isActive = self.provider.restorableData.currnetPage < 5
        self.tableViewDataSource = SRCContentTableViewDataSource(with: self.presenter, cellsDelegate: self)
        self.contentTableView.delegate = self.tableViewDataSource
        self.contentTableView.dataSource = self.tableViewDataSource
        self.observingID = self.provider.addObservingChanges(onChange: { [weak self](provider: SRCDataProvider) in
            if let theSelf = self
            {
                switch provider.state
                {
                case .failWithError:
                    let alertController = UIAlertController(title: "Error occured", message: provider.error?.localizedDescription, preferredStyle: .alert)
                    let alertAction = UIAlertAction.init(title: "OK", style: UIAlertActionStyle.default, handler: { (action:UIAlertAction) in
                    })
                    alertController.addAction(alertAction)

                    theSelf.present(alertController, animated: true, completion: nil)
                    theSelf.hideNotificationConstraint.isActive = false

                case .ready:
                    theSelf.presenter.update(with: provider.restorableData.articles)
                    theSelf.contentTableView.reloadData()
                default:
                    break
                }
            }
        })
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !UserDefaults.standard.bool(forKey: self.hasAlreadyLaunchedKey)
        {
            UserDefaults.standard.set(true, forKey: self.hasAlreadyLaunchedKey)
            let alertController = UIAlertController(title: "Tutorial", message: "Swipe left to move next page. \n Swipe right to move previous page. \n Tap to thumbnail for action. \n Have fun)", preferredStyle: .alert)
            let alertAction = UIAlertAction.init(title: "OK", style: UIAlertActionStyle.default, handler: { (action:UIAlertAction) in
            })
            alertController.addAction(alertAction)

            self.present(alertController, animated: true, completion: nil)

        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SRCShowFullSizeImage" {
            let destinationVC = segue.destination as! SRCShowFullSizeImageViewController
            destinationVC.urlToOpen = self.fullSizeURL
        }
    }

    @IBAction func unwindToRootController(segue:UIStoryboardSegue)
    {

    }
    
    //! Actions

    @IBAction func newContentViewTapped(_ gestureRecognizer: UITapGestureRecognizer)
    {
        self.provider.requestFirst()
        self.hideNotificationConstraint.isActive = true
    }

    @IBAction func contentViewSwapedLeft(_ gestureRecognizer: UISwipeGestureRecognizer)
    {
        self.provider.requestNext()

        if self.provider.restorableData.currnetPage > 4
        {
            self.hideNotificationConstraint.isActive = false
        }
    }

    @IBAction func contentViewSwapedRight(_ gestureRecognizer: UISwipeGestureRecognizer)
    {
        self.provider.requestPrevious()
        if self.provider.restorableData.currnetPage == 1
        {
            self.hideNotificationConstraint.isActive = true
        }
    }

    //! SRCArticleTableViewCellDelegate

    func receivedTap(onImageAt url: URL)
    {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let alertActionOpen = UIAlertAction.init(title: "Open full size", style: UIAlertActionStyle.default, handler: {[weak self] (action:UIAlertAction) in
                if let theSelf = self
                {
                    theSelf.fullSizeURL = url
                    theSelf.performSegue(withIdentifier: "SRCShowFullSizeImage", sender: theSelf)
                }
        })
        let alertActionOpenInSafary = UIAlertAction.init(title: "Open full size in safary", style: UIAlertActionStyle.default, handler: { (action:UIAlertAction) in
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        })
        let alertActionSave = UIAlertAction.init(title: "Save to foto", style: UIAlertActionStyle.destructive, handler: {[weak self] (action:UIAlertAction) in

            if let theSelf = self
            {
                theSelf.progressNotificationView.switchToCopying()
                theSelf.progressNotificationView.isHidden = false
                let requestController = SRCRedditThumbnailRequestController()
                requestController.sendThumbnailRequest(with: url, completion: { (image: UIImage?) in
                    if let theImage = image
                    {
                        OperationQueue.main.addOperation {
                                if let theSelf = self
                                {
                                    UIImageWriteToSavedPhotosAlbum(theImage, nil, nil, nil)
                                    theSelf.progressNotificationView.switchToSuccess()
                                    let deadlineTime = DispatchTime.now() + .seconds(1)
                                    DispatchQueue.main.asyncAfter(deadline: deadlineTime, execute: {
                                        if let theSelf = self
                                        {
                                            theSelf.progressNotificationView.isHidden = true
                                        }
                                    })
                                }
                            }
                        }
                    })
                }
            })
        let alertActionCancel = UIAlertAction.init(title: "Cancel", style: UIAlertActionStyle.cancel, handler: { (action:UIAlertAction) in
        })
        alertController.addAction(alertActionOpen)
        alertController.addAction(alertActionOpenInSafary)
        alertController.addAction(alertActionSave)
        alertController.addAction(alertActionCancel)

        self.present(alertController, animated: true, completion: nil)
    }

    //! Restoration app state

    override func encodeRestorableState(with coder: NSCoder)
    {
        super.encodeRestorableState(with: coder)

        let JSONData = try? JSONEncoder().encode(self.provider.restorableData)
        coder.encode(JSONData, forKey: self.restorableDataKey)
    }

    override func decodeRestorableState(with coder: NSCoder)
    {
        super.decodeRestorableState(with: coder)

        let restorableData = coder.decodeObject(forKey: self.restorableDataKey) as! Data

        let JSONData = try? JSONDecoder().decode(SRCDataProvider.RestorableData.self, from:
            restorableData)
        self.provider = SRCDataProvider(SRCRedditRequestController(), dataTranformer: SRCResponseDataTransformer(), restorableData: JSONData)

        self.initialize()
    }
}

