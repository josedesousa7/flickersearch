//
//  APIConstants.swift
//  flickersearchapp
//
//  Created by José Marques on 08/10/2020.
//

import Foundation

struct APIConstants {

    static let baseURL = "https://api.flickr.com/services/rest/"

    struct Authentication {
         static let APIkey = "f9cc014fa76b098f9e82f1c288379ea1"
    }

    struct QueryParameters {

        static let method = "method"
        static let format = "format"
        static let tags = "tags"
        static let page = "page"
        static let noJsonCallback = "nojsoncallback"
        static let apiKey = "api_key"
        static let photoId = "photo_id"
        static let perPage = "per_page"
    }

    struct ParametersValues {

        static let json = "json"
        static let noJsonCallback = 1
        static let perPage = 50
    }

    struct Url {
        static let search = "flickr.photos.search"
        static let sizes = "flickr.photos.getSizes"
    }

    struct PhotoSizeURL {
        static let large = "Large"
        static let largeSquare = "Large Square"
    }
}

