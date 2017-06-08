//
//  ViewController.swift
//  Image Fetching
//
//  Created by Vince Kearney on 08/06/2017.
//  Copyright © 2017 vince. All rights reserved.
//

import UIKit

let httpsImageUrl = "https://s-media-cache-ak0.pinimg.com/736x/5d/93/69/5d9369d9344d8b27b42ed8ae72ff2669.jpg"
let httpImageUrl = "http://www.puppiesden.com/pics/1/poodle-puppy2.jpg"

class ViewController: UIViewController
{
    // MARK: Properties
    @IBOutlet weak var imageView : UIImageView!
    fileprivate var imageToDownload : String?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.imageToDownload = httpsImageUrl
        self.imageView.contentMode = .scaleAspectFit
        
        self.downloadImage()
    }
    
    fileprivate func downloadImage()
    {
        let imageUrl = URL(string: self.imageToDownload!)
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
    
    @IBAction private func chooseImageDownloadType(_ sender: Any?)
    {
        print("Tapped the button")
        let alert = UIAlertController(title: "Change url type", message: "Which image type would you like to download?", preferredStyle: .alert)
        let httpAction = UIAlertAction(title: "HTTP", style: .default) { action in
            self.imageToDownload = httpImageUrl
            self.downloadImage()
        }
        let httpsAction = UIAlertAction(title: "HTTPS", style: .default) { action in
            self.imageToDownload = httpsImageUrl
            self.downloadImage()
        }
        alert.addAction(httpAction)
        alert.addAction(httpsAction)
        
        self.present(alert, animated: true, completion: nil)
    }
}
