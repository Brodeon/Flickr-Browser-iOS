//
//  FlickrPhoto.swift
//  Flickr Browser
//
//  Created by Przemek on 1/20/19.
//  Copyright © 2019 Przemek. All rights reserved.
//

import Foundation

class FlickrPhoto {
    
    var photoUrl: String = ""
    var title: String = ""
    var description: String = ""
    var author: String = ""
    
    var largePhotoUrl: String {
        get {
            var stringsArray = photoUrl.split(separator: ".")
            var stringURL = stringsArray[stringsArray.count - 2]
            
            return ""
        }
    }
    
//    private func replaceCharacter(string: String, at index: Int, withCharacter: Character) -> String {
//        var newString = string
//        
//        newString.remove()
//        newString.insert()
//        
//        return
//    }
    
}
