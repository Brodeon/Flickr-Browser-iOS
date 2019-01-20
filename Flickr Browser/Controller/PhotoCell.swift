//
//  PhotoCell.swift
//  Flickr Browser
//
//  Created by Przemek on 1/20/19.
//  Copyright © 2019 Przemek. All rights reserved.
//

import UIKit
import AlamofireImage

class PhotoCell: UITableViewCell {
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var photoTitlelabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func loadPhoto() {
        
    }

}
