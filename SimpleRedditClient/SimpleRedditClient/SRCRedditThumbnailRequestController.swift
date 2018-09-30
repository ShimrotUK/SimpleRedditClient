//
//  SRCRedditThumbnailRequestController.swift
//  SimpleRedditClient
//
//  Created by Eugen.Lysyuk on 9/30/18.
//  Copyright © 2018 SRC. All rights reserved.
//

import UIKit

class SRCRedditThumbnailRequestController
{
    func sendThumbnailRequest(with url: URL, completion:@escaping (UIImage?) -> Void)
    {
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request){
            (data: Data!, response: URLResponse!, error: Error!) -> Void in

            var image : UIImage?

            if let theData = data
            {
                image = UIImage(data: theData)
            }

            completion(image)
        }
        task.resume()
    }
}
