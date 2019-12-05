//
//  Photo.swift
//  InstaRover
//
//  Created by Elizabeth Letourneau on 12.01.19.
//  Copyright © 2019 Elizabeth Letourneau. All rights reserved.
//

import Foundation

struct PhotoResponse:Decodable {
    var photos:[PhotoDetail]
}

struct PhotoDetail:Decodable {
    var earth_date:String
    var img_src:String
}



