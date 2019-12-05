//
//  LoginViewController.swift
//  TrackThoughtfulTweets
//
//  Created by dirtbag on 12/2/19.
//  Copyright © 2019 dirtbag. All rights reserved.
//

import UIKit
import Accounts
import Swifter
import SafariServices

class LoginViewController: UIViewController, SFSafariViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
                
        var swifter = Swifter(consumerKey: "OsO1g0A09zaoPbffwd7zAIoE7", consumerSecret: "4bon6Kr4Ip5stbcZAgRkw69jD57zuzp90SE9n9V6GsNwVCd40i")
        
        let url = URL(string: "mcgoldrick://success")!
        
        testAuhorize1(swifter: swifter, url: url)
    }

    func testAuhorize1(swifter: Swifter, url: URL) {
      
        swifter.authorize(withCallback: url, presentingFrom: self, success: { _, _ in
            self.fetchTwitterHomeStream(swifter: swifter)
        }, failure:  { error in
            print ("Error: \(error.localizedDescription)")
        })
        
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
/*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? TweetsViewController else { return }
        destination.tweets = jsonResult
    }
*/
    func alert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
/*
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
 */
}
