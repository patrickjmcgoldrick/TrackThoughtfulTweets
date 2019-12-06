//
//  LoginViewController.swift
//  TrackThoughtfulTweets
//
//  Created by dirtbag on 12/2/19.
//  Copyright © 2019 dirtbag. All rights reserved.
//

import UIKit
import Swifter

class LoginViewController: UIViewController {
    
    
    var swifter = Swifter(consumerKey: "OsO1g0A09zaoPbffwd7zAIoE7", consumerSecret: "4bon6Kr4Ip5stbcZAgRkw69jD57zuzp90SE9n9V6GsNwVCd40i")
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
    }

    @IBAction func btnActionLogin(_ sender: Any) {
        
        guard let url = URL(string: "mcgoldrick://success")
            else { return }

        swifter.authorize(withCallback: url, presentingFrom: self,
            success: { _, _ in
                self.performSegue(withIdentifier: "toCreateTweet", sender: self)
            },
            failure:  { error in
                print ("Error: \(error.localizedDescription)")
            }
        )
        
    }

    func fetchTwitterHomeStream(swifter: Swifter) {
        swifter.getHomeTimeline(count: 20, success: { json in
            // Successfully fetched timeline, so lets create and push the table view
            var jsonResult = json.array ?? []
            print (jsonResult)
            //self.performSegue(withIdentifier: "showTweets", sender: self)
        }, failure:  { error in
            print ("Home Stream Error: \(error.localizedDescription)")
//            self.alert(title: "Home Stream Error", message: error.localizedDescription)
        })
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? CreateTweetViewController else { return }
        destination.swifter = swifter
    }

    func alert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
