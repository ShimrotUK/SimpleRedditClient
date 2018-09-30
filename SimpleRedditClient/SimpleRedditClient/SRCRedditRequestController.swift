//
//  SRCRedditRequestController.swift
//  SimpleRedditClient
//
//  Created by Eugen.Lysyuk on 9/29/18.
//  Copyright © 2018 SRC. All rights reserved.
//

import Foundation

class SRCRedditRequestController
{
    let baseURLComponents = URLComponents(string: "https://www.reddit.com/top.json")!
    let periodQueryItem = URLQueryItem(name: "t", value: "all")
    let recordCountItemName = "count"
    let afterIDItemName = "after"
    let beforeIDItemName = "before"
    let httpMethod = "GET"

    var task : URLSessionDataTask? = nil

    func sendRequest(with recordCount: Int, beforeID: String?, afterID: String?, completion:@escaping (Data?,  Error?) -> Void)
    {
        var urlComponents = baseURLComponents
        var queryItems = [periodQueryItem, URLQueryItem(name: recordCountItemName, value: String(recordCount))]

        if beforeID != nil
        {
            queryItems.append(URLQueryItem(name: beforeIDItemName, value: beforeID))
        }

        if afterID != nil
        {
            queryItems.append(URLQueryItem(name: afterIDItemName, value: afterID))
        }

        urlComponents.queryItems = queryItems

        let url = urlComponents.url
        var request = URLRequest(url: url!)
        request.httpMethod = httpMethod
        task = URLSession.shared.dataTask(with: request){
            (data: Data!, response: URLResponse!, error: Error!) -> Void in
            completion(data, error)
        }
        task!.resume()
    }

    func cancelCurrentActivities()
    {
        task?.cancel()
    }
}
