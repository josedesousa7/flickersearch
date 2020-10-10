//
//  Photos.swift
//  FlickrSearchApp
//
//  Created by José Marques on 15/10/2019.
//  Copyright © 2019 José Marques. All rights reserved.
//

import Foundation

struct Photos : Codable {
    let page, pages, perpage : Int
    let total : String
    let photo : [Photo]
}
