//
//  CreateTweetViewController.swift
//  TrackThoughtfulTweets
//
//  Created by dirtbag on 12/5/19.
//  Copyright © 2019 dirtbag. All rights reserved.
//

import UIKit

class CreateTweetViewController: UIViewController, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var tfTweet: UITextField!
    
    var imagePicker: UIImagePickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self
        // Do any additional setup after loading the view.
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
