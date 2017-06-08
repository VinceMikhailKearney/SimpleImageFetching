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

let httpsImageUrl = "https://s-media-cache-ak0.pinimg.com/736x/5d/93/69/5d9369d9344d8b27b42ed8ae72ff2669.jpg"
let httpImageUrl = "http://www.puppiesden.com/pics/1/poodle-puppy2.jpg"

class ViewController: UIViewController
{
    // MARK: Properties
    @IBOutlet weak var imageView : UIImageView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.imageView.contentMode = .scaleAspectFit
        self.downloadImage(.HTTPS)
    }
    
    fileprivate func downloadImage(_ type : URL_TYPE)
    {
        let imageUrl = URL(string: type == .HTTP ? httpImageUrl : httpsImageUrl)
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
        let alert = UIAlertController(title: "Change URL Type", message: "Which image type would you like to download?", preferredStyle: .alert)
        let httpAction = UIAlertAction(title: "HTTP", style: .default) { action in
            self.downloadImage(.HTTP)
        }
        let httpsAction = UIAlertAction(title: "HTTPS", style: .default) { action in
            self.downloadImage(.HTTPS)
        }
        alert.addAction(httpAction)
        alert.addAction(httpsAction)
        
        self.present(alert, animated: true, completion: nil)
    }
}
