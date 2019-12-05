//
//  PhotosTableViewController.swift
//  InstaRover
//
//  Created by Brian Advent on 09.05.19.
//  Copyright © 2019 Brian Advent. All rights reserved.
//

import UIKit
import SDWebImage

class RoverTableViewCell: UITableViewCell {
    @IBOutlet weak var roverImage: UIImageView!
    
}


class PhotosTableViewController: UITableViewController {


    @IBOutlet weak var searchBar: UISearchBar!
    
    var listOfPhotos = [PhotoDetail]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.navigationItem.title = "\(self.listOfPhotos.count) Photos found"
            }
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfPhotos.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        as! RoverTableViewCell
        let photo = listOfPhotos[indexPath.row]
       // let placeholderImage = UIImage(named: "placeholderImage")
        let imageURL = URL(string: photo.img_src)
       // let placeholderImage = UIImage(named: "placeholder")
       // cell.textLabel?.text = photo.img_src
       // cell.detailTextLabel?.text = photo.earth_date
        //cell.imageView?.sd_setImage(with: imageURL)
        cell.roverImage.sd_setImage(with: imageURL)
        cell.contentView.addSubview(cell.imageView!)
        
        return cell
    }
    

    

}

extension PhotosTableViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchBarText = searchBar.text else {return}
        let photoRequest = PhotoRequest(rover: searchBarText)
        photoRequest.getPhotos { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let photos):
                self?.listOfPhotos = photos
            }
        }
        
    }
}
