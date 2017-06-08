//
//  ViewController.swift
//  Image Fetching
//
//  Created by Vince Kearney on 08/06/2017.
//  Copyright © 2017 vince. All rights reserved.
//

import UIKit

let gokuSSJ4 = "https://s-media-cache-ak0.pinimg.com/736x/4a/64/73/4a647319672cc080e9eb8dac1c73e3ab.jpg"

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
            
            guard (response as? HTTPURLResponse)?.statusCode == 200 else { self.showHud(withText: "Failed to download image"); return }
            
            print("Downloading image finished")
            let downloadImage = UIImage(data: data!)
            DispatchQueue.main.async { self.imageView.image = downloadImage }
            self.showHud(withText: "Image downloaded")
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
    
    func showHud(withText text : String)
    {
        DispatchQueue.main.sync
        {
            let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
            hud.mode = .text
            hud.offset = CGPoint(x: 0,y :10000)
            hud.label.text = text
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
}
