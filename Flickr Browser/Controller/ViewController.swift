//
//  ViewController.swift
//  Flickr Browser
//
//  Created by Przemek on 1/20/19.
//  Copyright © 2019 Przemek. All rights reserved.
//

import UIKit

class ViewController: UIViewController, FlickrPhotosRepoDelegate{
    
    var photosArray = [FlickrPhoto]()
    var photoRepo: FlickrPhotosRepo?
    
    @IBOutlet weak var photosTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        photosTableView.delegate = self
        photosTableView.dataSource = self
        photoRepo = FlickrPhotosRepo(delegate: self)
        
        photoRepo?.downloadPhotosData(tags: "cars")
        setTableViewheight()
    }
    
    func dataDownloaded(photos: [FlickrPhoto]?, error: FlickrError?) {
        if let err = error {
            print(err.errorDescription())
            return
        }
        guard let photosArray = photos else { return }
        self.photosArray = photosArray
        
        photosTableView.reloadData()
        setTableViewheight()
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photosArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = photosTableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath) as! PhotoCell
        let flickrPhoto = photosArray[indexPath.row]
        cell.photoTitlelabel.text = flickrPhoto.title
        
        return cell
    }
    
    func setTableViewheight() {
        self.photosTableView.rowHeight = UITableView.automaticDimension
        self.photosTableView.estimatedRowHeight = 250.0
    }
}


