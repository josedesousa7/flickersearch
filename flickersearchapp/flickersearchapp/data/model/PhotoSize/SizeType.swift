//
//  SizeType.swift
//  FlickrSearchApp
//
//  Created by José Marques on 21/10/2019.
//  Copyright © 2019 José Marques. All rights reserved.
//

import Foundation

enum SizeType {
    case largeSquare
    case large
    var sizetype: String {
        switch self {
        case .largeSquare:
            return APIConstants.PhotoSizeURL.largeSquare
        case .large:
            return APIConstants.PhotoSizeURL.large
        }
    }
}
