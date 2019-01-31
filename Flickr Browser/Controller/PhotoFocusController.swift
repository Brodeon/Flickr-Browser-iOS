//
//  PhotoFocusController.swift
//  Flickr Browser
//
//  Created by Przemek on 1/24/19.
//  Copyright © 2019 Przemek. All rights reserved.
//

import UIKit
import AlamofireImage

class PhotoFocusController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var focusedImageView: UIImageView!
    @IBOutlet weak var imgScrollView: UIScrollView!
    
    var photoURL: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imgScrollView.delegate = self
        
        if let url = photoURL {
            focusedImageView.af_setImage(withURL: URL(string: url)!)
            print(url)
        }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.focusedImageView
    }
    


}
