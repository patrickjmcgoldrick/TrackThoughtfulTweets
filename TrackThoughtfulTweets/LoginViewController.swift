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
        
        print ("Starting process")
        
        var swifter = Swifter(consumerKey: "OsO1g0A09zaoPbffwd7zAIoE7", consumerSecret: "4bon6Kr4Ip5stbcZAgRkw69jD57zuzp90SE9n9V6GsNwVCd40i")
        
        //guard let url = URL(string: "https://zappycode.com/") else { return }
        let url = URL(string: "mcgoldrick://success")!
        
        testAuhorize1(swifter: swifter, url: url)
        
        //testAuthorize2(swifter: swifter, url: url)
        
        //testACA(swifter: swifter)
    }

    func testAuhorize1(swifter: Swifter, url: URL) {
    
        swifter.authorize(with: url, presentFrom: self, success: { (token, response) in
            print ("SuCCESS!")
            print (token.debugDescription)
        }, failure: { error in
            print ("failure: \(error.localizedDescription)")
        })
        
        /*
        swifter.authorize(withCallback: url, presentingFrom: self, success: { _, _ in
            self.fetchTwitterHomeStream(swifter: swifter)
        }, failure:  { error in
            print ("Error: \(error.localizedDescription)")
        })
        */
    }

    func testAuthorize2(swifter: Swifter, url: URL) {
        /*
        swifter.authorize(withCallback: url, presentingFrom: self, forceLogin: false, safariDelegate: self, success: { (token, response) in
            print ("Success!, We got here.")
        }) { (error) in
            print ("Error: \(error.localizedDescription)")
        }
*/
    }
    func testACA(swifter: Swifter) {
        let store = ACAccountStore()
        let type = store.accountType(withAccountTypeIdentifier: ACAccountTypeIdentifierTwitter)
        store.requestAccessToAccounts(with: type, options: nil) { granted, error in
            guard let twitterAccounts = store.accounts(with: type), granted else {
                print("Error: \(error!.localizedDescription)")
                return
            }

            if twitterAccounts.isEmpty {
                print("Error: - - There are no Twitter accounts configured. You can add or create a Twitter account in Settings.")
            } else {
                let twitterAccount = twitterAccounts[0] as! ACAccount
                let newSwifter = Swifter(account: twitterAccount)
                print ("Success, we did it. I think.")
                //self.fetchTwitterHomeStream(swifter: newSwifter)
            }
        }
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

    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
 
}
