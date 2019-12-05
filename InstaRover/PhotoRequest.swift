//
//  PhotoRequest.swift
//  InstaRover
//
//  Created by Elizabeth Letourneau on 12.01.19.
//  Copyright © 2019 Elizabeth Letourneau. All rights reserved.
//

import Foundation

enum PhotoError:Error {
    case noDataAvailable
    case canNotProcessData
}

struct PhotoRequest {
    let resourceURL:URL
    let API_KEY = "FKWe719OjxjTBFruoFfbwiwIaJxWU5gdfKq0OKb3"
    
    
    init(rover:String) {
        let resourceString = "https://api.nasa.gov/mars-photos/api/v1/rovers/\(rover)/photos?sol=1&api_key=\(API_KEY)"
        guard let resourceURL = URL(string: resourceString) else {fatalError()}
        
        self.resourceURL = resourceURL
        
    }
    
    func getPhotos (completion: @escaping(Result<[PhotoDetail], PhotoError>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: resourceURL) { data, _, _ in
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let photosResponse = try decoder.decode(PhotoResponse.self, from: jsonData)
                let photosDetails = photosResponse.photos
                completion(.success(photosDetails))
            }catch{
                completion(.failure(.canNotProcessData))
            }
            
        }
        dataTask.resume()
    }
    
    
    
}
