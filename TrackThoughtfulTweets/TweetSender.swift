//
//  SendTweet.swift
//  TrackThoughtfulTweets
//
//  Created by dirtbag on 12/5/19.
//  Copyright © 2019 dirtbag. All rights reserved.
//

import Foundation
import Swifter

final class TweetSender {

    let swifter: Swifter
    
    // init with OAuth ibrary object
    init(swifter: Swifter) {
        self.swifter = swifter
    }
    
    func send(status: String, imageData: Data?, posted: @escaping (String?) -> Void) {
                
        // Tweet with Image
        if let data = imageData {
            // we have an image, post to twitter server
            swifter.postTweet(status: status, media: data,
                success: { success in
                    print ("Success: posted a status w/Image")
                    posted(nil)
                },
                failure: { failure in
                    print ("Failed: posted a status w/Image")
                    print(failure.localizedDescription)
                    posted(failure.localizedDescription)
                }
            )
        } else {
            // post status without Image
            self.swifter.postTweet(status: status,
                success: { success in
                    print ("Success: posted a status")
                    posted(nil)

                },
                failure: { failure in
                    print ("Failed: posted a status")
                    print(failure.localizedDescription)

                    posted(failure.localizedDescription)
                }
            )
        }
    }
    
}
