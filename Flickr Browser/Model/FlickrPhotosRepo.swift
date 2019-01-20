//
//  FlickrPhotosRepo.swift
//  Flickr Browser
//
//  Created by Przemek on 1/20/19.
//  Copyright © 2019 Przemek. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

enum FlickrError: String, Error {
    case connectionError = "Cannot download data from internet"
    case parseError = "Cannot parse data"
    
    func errorDescription() -> String {
        return self.rawValue
    }
}

protocol FlickrPhotosRepoDelegate {
    func dataDownloaded(photos: [FlickrPhoto]?, error: FlickrError?)
}

class FlickrPhotosRepo {
    
    let API_URL = "https://api.flickr.com/services/feeds/photos_public.gne"
    let url = "https://api.flickr.com/services/feeds/photos_public.gne?lang=en-EN&tagmode=ANY&format=json&nojsoncallback=1&tags=cars"
    var delegate: FlickrPhotosRepoDelegate?
    
    init(delegate: FlickrPhotosRepoDelegate) {
        self.delegate = delegate
    }
    
    func downloadPhotosData(tags: String) {
        let params: [String : Any] = ["lang" : "en-EN",
                                      "tagmode" : "ANY",
                                      "format" : "json",
                                      "nojsoncallback" : 1,
                                      "tags" : tags]
        
        Alamofire.request(self.API_URL, method: .get, parameters: params).responseJSON { response in
            if response.result.isSuccess {
                let resultJSON = JSON(response.result.value!)
                let title = resultJSON["title"].string
                
                if title == "" {
                    self.delegate?.dataDownloaded(photos: nil, error: FlickrError.parseError)
                    return
                }
                
                self.createPhotosArray(data: resultJSON)
            } else {
                self.delegate?.dataDownloaded(photos: nil, error: FlickrError.parseError)
            }
        }
    }
    
    func createPhotosArray(data: JSON) {
        var dataArray = [FlickrPhoto]()
        let jsonArray = data["items"].arrayValue
        
        for photoData in jsonArray {
            let photo = FlickrPhoto()

            photo.title = photoData["title"].stringValue
            photo.author = photoData["author"].stringValue
            photo.description = photoData["description"].stringValue
            photo.photoUrl = photoData["link"].stringValue
            
            dataArray.append(photo)
        }
        
        self.delegate?.dataDownloaded(photos: dataArray, error: nil)
        
    }
}
