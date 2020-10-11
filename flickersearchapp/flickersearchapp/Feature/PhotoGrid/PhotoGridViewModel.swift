//
//  PhotoGridViewModel.swift
//  flickersearchapp
//
//  Created by José Marques on 10/10/2020.
//  Copyright © 2020 José Marques. All rights reserved.
//

import UIKit
import Foundation

protocol PhotoGridViewModelDelegate {
    func didFinishLaunching()
}

protocol PhotoGridViewModelProtocol {
      var photos: [Photo]? { get }
      func getPhotos(tags: String)
      func getLargeSquareImage(for photo: Photo,  completion: @escaping (_ image: UIImage) -> Void)
  }

class PhotoGridViewModel : PhotoGridViewModelProtocol {

    var photos: [Photo]?
    private var networkService = RequestManager()
    var delegate : PhotoGridViewModelDelegate?
    private var pageRequest : Int = 1

    func getPhotos(tags: String) {
        let trimmedString = tags.replacingOccurrences(of: " ", with: "")
        self.networkService.getPhotos(page: pageRequest, tags: trimmedString) { result in
            switch result {
            case .success(let photos):
                self.photos = photos
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    func getLargeSquareImage(for photo: Photo, completion: @escaping (UIImage) -> Void) {
        self.networkService.getPhotoSizeURL(photo: photo, sizeType: .largeSquare) { photoURL in
            if let sizeURL = photoURL {
                self.networkService.getImage(sizeURL:sizeURL) { result in
                    switch result {
                    case .success(let image):
                        if let imageUnwraped = image {
                            completion(imageUnwraped)
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
}
