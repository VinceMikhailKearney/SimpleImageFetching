//
//  ViewController.swift
//  Image Fetching
//
//  Created by Vince Kearney on 08/06/2017.
//  Copyright © 2017 vince. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    // MARK: Properties
    @IBOutlet weak var imageView : UIImageView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        let imageUrl = URL(string: "https://s-media-cache-ak0.pinimg.com/736x/b7/ef/bc/b7efbcd8320cb753978d6c2d551785aa.jpg")
        
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
}
