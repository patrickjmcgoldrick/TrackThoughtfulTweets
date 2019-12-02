//
//  TwitterDataLoader.swift
//  TrackThoughtfulTweets
//
//  Created by dirtbag on 12/1/19.
//  Copyright © 2019 dirtbag. All rights reserved.
//

import Foundation

class TwitterDataLoader {
    
    // MARK - User Profile
    
    static let profileUrlString = "https://api.twitter.com/labs/1/users?usernames=ScottAdamsSays&format=detailed"
    
    func loadTwitterProfile(completed: @escaping (Data) -> ()) {
        
        loadData(urlString: TwitterDataLoader.profileUrlString) { (data) in
            
            completed(data)
            
        }
    }
    
    // MARK - Recent Tweets
    
    static let recentTweetsUrlString = "https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name=scottadamssays&count="
    
    func loadMostRecentTweets(numberOfTweets: Int, completed: @escaping (Data) -> ()) {
        
        let urlString = ("\(TwitterDataLoader.recentTweetsUrlString)\(numberOfTweets)")
        
        loadData(urlString: urlString) { (data) in
            
            completed(data)
            
        }
    }
    
    // MARK - Generic load data from URL using GET
    
    private func loadData(urlString: String, loaded: @escaping (Data) -> ()) {
                
        guard let url = URL(string: urlString) else { return }

         var request: URLRequest = URLRequest(url: url)
         
         request.setValue("Bearer AAAAAAAAAAAAAAAAAAAAAPomBAEAAAAANTDCDCmQ2f1h0oGTN6VWGmFejuc%3DwYL5rdWLqYce7h55n8sJl8u10RDyeljEtsWCwRHmpumdI5warV", forHTTPHeaderField: "Authorization")
             
         URLSession.shared.dataTask(with: request) { (data, response, error) in
             
             guard let data = data else { return }

             loaded(data)

         }.resume()
    }
    
}
