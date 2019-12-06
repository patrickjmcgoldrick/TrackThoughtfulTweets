//
//  CreateTweetViewController.swift
//  TrackThoughtfulTweets
//
//  Created by dirtbag on 12/5/19.
//  Copyright © 2019 dirtbag. All rights reserved.
//

import UIKit
import Swifter

class CreateTweetViewController: UIViewController, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var tfTweet: UITextField!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var swifter: Swifter?
    var defaultImage = UIImage(named: "defaultImage")
    var imagePicker: UIImagePickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self

        imageView.image = defaultImage
    }
    
    @IBAction func btnActionImage(_ sender: Any) {
    
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)

    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func btnActionSend(_ sender: Any) {
        

        var data: Data? = nil
    
        activityIndicator.isHidden = false

        // convert image to Data object
        if let image = imageView.image {
            
            if image != defaultImage { // don't post default image
                // try png
                data = image.pngData()
                
                // if not, try jpeg
                if data == nil {
                    data = image.jpegData(compressionQuality: 0.80)
                }
            }
        }
        
        // if we have a status, update status on twitter
        if let status = tfTweet.text {
            sendTweet(status: status, imageData: data)
        }
    }
    
    private func sendTweet(status: String, imageData: Data?) {
        
        guard let swifter = self.swifter else { return }

        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        let sender = TweetSender(swifter: swifter)
        sender.send(status: status, imageData: imageData) { (error) in
            self.activityIndicator.isHidden = true
            self.activityIndicator.stopAnimating()
            
            if let error = error {
                self.alert(title: "Status Update Failed", message: error)
            }
            
            _ = self.navigationController?.popViewController(animated: true)
        }
    }
    
    private func alert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension CreateTweetViewController: UIImagePickerControllerDelegate {
    
    // Picked an image chosen, set in ImageView
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
                        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = image
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    // No image chosen, just dismiss popup
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print ("dismissed")
        picker.dismiss(animated: true, completion: nil)
    }
}
