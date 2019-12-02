//
//  ViewController.swift
//  TrackThoughtfulTweets
//
//  Created by dirtbag on 11/29/19.
//  Copyright © 2019 dirtbag. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var lblDescription: UILabel!
    
    @IBOutlet weak var ivProfile: UIImageView!
    
    @IBOutlet weak var tvPosts: UITableView!
    
    var user : User?
    //let dataSource: UITableViewDataSource = FeedDataSource()
    var tweets = [Tweet]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tvPosts.delegate = self
        tvPosts.dataSource = self
        
        loadUserData()
        
        loadFeedData()
        
    }

    private func loadUserData() {
        
        let loader = TwitterDataLoader()
        
        loader.loadTwitterProfile { (data) in
            
            self.parseData(data: data)

        }
    
    }

    private func loadFeedData() {
        
        let loader = TwitterDataLoader()
        
        loader.loadMostRecentTweets(numberOfTweets: 10) { (data) in
            
            self.parseFeedData(data: data)
        }
    }
  
    private func parseData(data: Data) {
        
        print (data.debugDescription)
        
        // background the loading / parsing elements
        DispatchQueue.global(qos: .background).async {

            do {

                // create decoder
                let jsonDecoder = JSONDecoder()

                // decode json into structs
                let userData = try jsonDecoder.decode(UserData.self, from: data)

                // save track rows for detail view
                self.user = userData.data[0]

            } catch {
                print ("Error Parsing JSON: \(error.localizedDescription)")
            }

            DispatchQueue.main.async {
                guard let user = self.user
                    else { return }
                self.lblName.text = user.name
                self.lblDescription.text = user.description
                print (user.profile_image_url)
                
                self.tvPosts.reloadData()
            }
        }
 

    }
    
    private func parseFeedData(data: Data) {
              
        print (String(bytes: data, encoding: .utf8)!)
        
        // background the loading / parsing elements
        DispatchQueue.global(qos: .background).async {

        do {

            // create decoder
            let jsonDecoder = JSONDecoder()

            // decode json into structs
            self.tweets = try jsonDecoder.decode([Tweet].self, from: data)

           } catch {
               print ("Error Parsing JSON: \(error.localizedDescription)")
           }

           DispatchQueue.main.async {
                
               self.tvPosts.reloadData()
           }
       }


   }
}

extension FeedViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as? FeedTableViewCell else { return UITableViewCell() }
        
        cell.lblText.text = tweets[indexPath.row].text
        //cell.backgroundColor = UICo
        
        return cell
    }
}

