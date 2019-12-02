//
//  ViewController.swift
//  TrackThoughtfulTweets
//
//  Created by dirtbag on 11/29/19.
//  Copyright © 2019 dirtbag. All rights reserved.
//

import UIKit
import Social

class FeedViewController: UIViewController, UITableViewDelegate {

    // Mark - Outlets
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var lblDescription: UILabel!
    
    @IBOutlet weak var ivProfile: UIImageView!
    
    @IBOutlet weak var tvPosts: UITableView!
    
    /// MARK - parameters
    var user : User?
    var tweets = [Tweet]()

    /// MARK - View Did Load
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
        
        let loadAmount = tweets.count + 10
        
        loader.loadMostRecentTweets(numberOfTweets: loadAmount) { (data) in
            
            self.parseFeedData(data: data)
        }
    }
  
    private func parseData(data: Data) {
                
        print (String(bytes: data, encoding: .utf8)!)

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
                
                self.loadImageInto(imageView: self.ivProfile, urlString: user.profile_image_url)
                
                print (user.profile_image_url)
                
                self.tvPosts.reloadData()
            }
        }
 

    }
    
    private func parseFeedData(data: Data) {
             
        if tweets.count == 0 {
            print (String(bytes: data, encoding: .utf8)!)
        }
        
        
        // background the loading / parsing elements
        DispatchQueue.global(qos: .background).async {

            do {

                // create decoder
                let jsonDecoder = JSONDecoder()

                // decode json into structs
                let temp = try jsonDecoder.decode([Tweet].self, from: data)

                if self.tweets.count == 0 {
                    self.tweets = temp
                } else {
                    for index in self.tweets.count..<temp.count {
                        self.tweets.append(temp[index])
                    }
                }
                
                assert(self.tweets.count == temp.count, "tweets.count: \(self.tweets.count) should equal temp.count: \(temp.count)")
                
            } catch {
                print ("Error Parsing JSON: \(error.localizedDescription)")
            }

            DispatchQueue.main.async {
                
                self.tvPosts.reloadData()
            }
       }


    }
    
    /// Code from youtube video:  https://www.youtube.com/watch?v=edENrmrAOB4
    
    @IBAction func btnActionPost(_ sender: Any) {
        
        if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter) {
            
            guard let tweetController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
                else { return }
            
            tweetController.setInitialText("Your tweet goes here...")
            self.present(tweetController, animated: true, completion: nil)
            
        } else {
            
            let alert = UIAlertController(title: "Accounts",
                                          message: "Please login to your twitter.",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            alert.addAction(UIAlertAction(title: "Settings", style: .default, handler: {
                (alertAction) in
                
                let settingsURL = URL(string: UIApplication.openSettingsURLString)
                
                if let url = settingsURL {
                    UIApplication.shared.openURL(url)
                }
                
            }))
            
            self.present(alert, animated: true, completion: nil)

            
        }
        
        
        
        
    }
}

extension FeedViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // get me X more rows
        if indexPath.row == (tweets.count - 1) {
            print ("Getting more rows")
            loadFeedData()
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as? FeedTableViewCell else { return UITableViewCell() }
        
        cell.lblText.text = tweets[indexPath.row].text
        //cell.backgroundColor = UICo
        
        return cell
    }
    
    private func loadImageInto(imageView: UIImageView, urlString: String) {
        
        DispatchQueue.global(qos: .userInteractive).async {

            ImageLoader().loadImage(urlString: urlString) { (data) in

                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        imageView.image = image
                    }
                }
            }
          
        }
        
    }
    
}


