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
    var selectedFlickrPhoto: FlickrPhoto?
    
    @IBOutlet weak var photosTableView: UITableView!
    @IBOutlet weak var tagsSearchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tagsSearchBar.delegate = self
        photosTableView.delegate = self
        photosTableView.dataSource = self
        photoRepo = FlickrPhotosRepo(delegate: self)
        
        photoRepo?.downloadPhotosData(tags: "planes")
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPhotoDetail" {
            let destination = segue.destination as! PhotoDetailController
            destination.detailedPhoto = selectedFlickrPhoto
        }
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
        print(flickrPhoto.photoUrl)
        cell.loadPhoto(imageUrl: flickrPhoto.photoUrl)
        
        return cell
    }
    
    func setTableViewheight() {
        self.photosTableView.rowHeight = UITableView.automaticDimension
        self.photosTableView.estimatedRowHeight = 250.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedFlickrPhoto = photosArray[indexPath.row]
        photosTableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "toPhotoDetail", sender: self)
    }
}

extension ViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    
        if let tags = searchBar.text {
            photoRepo?.downloadPhotosData(tags: tags)
            searchBar.text = ""
            searchBar.endEditing(true)
        }
        
    }
}


