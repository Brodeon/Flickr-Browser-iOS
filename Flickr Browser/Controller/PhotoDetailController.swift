//
//  PhotoDetailController.swift
//  Flickr Browser
//
//  Created by Przemek on 1/20/19.
//  Copyright © 2019 Przemek. All rights reserved.
//

import UIKit
import AlamofireImage

class PhotoDetailController: UIViewController {

    var detailedPhoto: FlickrPhoto?
    var originImageFrame: CGRect?
    
    @IBOutlet var photoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var photoRightConstraint: NSLayoutConstraint!
    @IBOutlet weak var photoLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var photoTopConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let photo = detailedPhoto else{ return }
        guard let photoURL = URL(string: photo.photoUrl) else { return }
        
        photoImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(performImageViewZoom)))
        originImageFrame = photoImageView.frame
        
        photoImageView.af_setImage(withURL: photoURL, placeholderImage: UIImage(named: "Flickr"))
        titleLabel.text = "Title: \(photo.title)"
        authorLabel.text = "Author: \(photo.author)"
        descriptionLabel.text = "Tags: \(photo.description)"
    }
    
    @objc func performImageViewZoom(sender: UITapGestureRecognizer) {
        let imageView = sender.view as! UIImageView
        
        let parentViewWidth = self.view.frame.width
        let imageViewWidth = imageView.frame.width
        let imageViewHeight = imageView.frame.height
        
        let calculatedHeight = (imageViewHeight * parentViewWidth) / imageViewWidth
        self.view.bringSubviewToFront(self.photoImageView)
      
        self.view.layoutIfNeeded()

        UIView.animate(withDuration: 0.4, animations: {
            
            imageView.frame.size.width = parentViewWidth
            imageView.frame.size.height = calculatedHeight
            imageView.center = self.view.center
            
        }) { isDone in
            self.photoImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.performImageViewUnzoom)))
        }
        
    }
    
    @objc func performImageViewUnzoom(sender: UITapGestureRecognizer) {
        let imageView = sender.view as! UIImageView

        self.view.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.4, animations: {
            imageView.frame = self.originImageFrame!
        }) { isDone in
            self.photoImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.performImageViewZoom)))
        }
    }

}
