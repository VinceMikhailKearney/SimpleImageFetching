//
//  ViewController.swift
//  Image Fetching
//
//  Created by Vince Kearney on 08/06/2017.
//  Copyright © 2017 vince. All rights reserved.
//

import UIKit

enum URL_TYPE {
    case HTTP
    case HTTPS
}

let gokuSSJ4 = "https://s-media-cache-ak0.pinimg.com/736x/4a/64/73/4a647319672cc080e9eb8dac1c73e3ab.jpg"
let httpImageUrl = "http://www.puppiesden.com/pics/1/poodle-puppy2.jpg"

class ViewController: UIViewController, UITextFieldDelegate
{
    // MARK: Properties
    @IBOutlet weak var imageView : UIImageView!
    @IBOutlet weak var downloadButton : UIButton!
    @IBOutlet weak var urlTextField : UITextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.imageView.contentMode = .scaleAspectFit
        self.downloadButton.layer.cornerRadius = 5
        self.downloadImage()
        self.view.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(hideKeyboard)))
        self.urlTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.urlTextField.text = "" // Blank out text and download placeholder image
        self.downloadImage()
    }
    
    func downloadImage()
    {
        self.hideKeyboard()
        let imageUrl = URL(string: (self.urlTextField.text?.characters.count)! > 0 ? self.urlTextField.text! : gokuSSJ4)
        let task = URLSession.shared.dataTask(with: imageUrl!)
        { (data, response, error) in
            if error == nil {
                print("Downloading image finished")
                let downloadImage = UIImage(data: data!)
                DispatchQueue.main.async {
                    self.imageView.image = downloadImage
                }
            }
        }
        task.resume()
    }
    
    @IBAction func downloadUrl(_ sender: Any?) {
        self.downloadImage()
    }
    
    // MARK: UITextFieldDelegate methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("Pressed return key")
        self.downloadImage()
        return false;
    }
    
    // MARK: Helpers
    func hideKeyboard() {
        self.urlTextField.resignFirstResponder()
    }
}
