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
    
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let photo = detailedPhoto else{ return }
        guard let photoURL = URL(string: photo.photoUrl) else { return }
        
        photoImageView.af_setImage(withURL: photoURL, placeholderImage: UIImage(named: "Flickr"))
        titleLabel.text = "Title: \(photo.title)"
        authorLabel.text = "Author: \(photo.author)"
        descriptionLabel.text = "Tags: \(photo.description)"
    }

}
