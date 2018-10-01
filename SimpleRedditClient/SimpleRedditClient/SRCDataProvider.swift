//
//  SRCDataProvider.swift
//  SimpleRedditClient
//
//  Created by Eugen.Lysyuk on 9/26/18.
//  Copyright © 2018 SRC. All rights reserved.
//

import Foundation

class SRCDataProvider
{
    typealias SRCObservingChangesClosure = ((SRCDataProvider) -> Void)

    private let articlesPerPage = 25
    private var observingChangesClosures = [UUID:SRCObservingChangesClosure]()
    private var requestController : SRCRedditRequestController
    private var dataTranformer : SRCResponseDataTransformer

    private(set) var error : Error? = nil
    private(set) var articles : [SRCRedditArticleEntity]?

    enum ProviderState
    {
        case ready
        case pendingRequest
        case decodingJSON
        case failWithError
    }

    private(set) var state : ProviderState = .ready
    private(set) var currnetPage = 1

    init(_ requestController: SRCRedditRequestController, dataTranformer: SRCResponseDataTransformer)
    {
        self.requestController = requestController
        self.dataTranformer = dataTranformer
    }

    deinit {
       self.requestController.cancelCurrentActivities()
    }

    func addObservingChanges(onChange closure: @escaping SRCObservingChangesClosure) -> UUID
    {
        let closureID = UUID()
        self.observingChangesClosures[closureID] = closure

        return closureID
    }

    func removeObservingChanges(_ token: UUID)
    {
        self.observingChangesClosures.removeValue(forKey: token)
    }

    func requestFirst()
    {
        self.currnetPage = 1
        self.request(count: articlesPerPage * self.currnetPage, beforeID: nil, afterID: nil)
    }

    func requestNext()
    {
        if let theArticles = self.articles, theArticles.count > 0
        {
            self.currnetPage += 1
            self.request(count: articlesPerPage * self.currnetPage, beforeID: nil, afterID: theArticles.last?.name)
        }
    }

    func requestPrevious()
    {
        if let theArticles = self.articles, theArticles.count > 0 && self.currnetPage > 1
        {
            self.currnetPage -= 1
            self.request(count: articlesPerPage * self.currnetPage, beforeID: theArticles.first?.name, afterID: nil)
        }
    }

    private func request(count:Int, beforeID: String?, afterID: String?)
    {
        switch self.state
        {
            case .pendingRequest:
                self.requestController.cancelCurrentActivities()
                fallthrough
            case .ready, .decodingJSON, .failWithError:
                self.state = .pendingRequest
                self.requestController.sendRequest(with: count, beforeID: beforeID, afterID: afterID){
                    (dataResult: Data!, error: Error!) -> Void in

                    if error != nil
                    {
                        guard let theError = error as? URLError, theError.code != URLError.cancelled else
                        {
                            return
                        }

                        self.state = .failWithError
                        self.error = error
                    }
                    else
                    {
                        self.state = .decodingJSON
                        do {
                            self.articles = try self.dataTranformer.transform(JSONData: dataResult!)
                            self.state = .ready
                        }
                        catch
                        {
                            self.error = error
                            self.state = .failWithError
                        }
                    }

                    for closure in self.observingChangesClosures.values
                    {
                        OperationQueue.main.addOperation {
                            closure(self)
                        }
                    }
                }
        }
    }
}
