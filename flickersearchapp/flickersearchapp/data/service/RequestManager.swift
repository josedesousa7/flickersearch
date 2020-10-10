//
//  RequestManager.swift
//  flickersearchapp
//
//  Created by José Marques on 10/10/2020.
//

import Foundation
import UIKit

protocol RequestManagerProtocol : AnyObject {
    func getPhotos(page: Int, tags:String, completion: @escaping (Result<[Photo], HttpProviderError>) -> Void)
    func getPhotoSizes(photo: Photo, completion:@escaping (Result<[Size], HttpProviderError>) -> Void)
    func getImage(sizeURL: Size, completion: @escaping (Result<UIImage?, HttpProviderError>) -> Void)
    func getPhotoSizeURL(photo: Photo, sizeType: SizeType, completion: @escaping (_ sizeURL : Size?) ->()) -> Void
}

final class RequestManager: HttpProvider {

}

extension HttpProvider: RequestManagerProtocol {

    func getPhotos(page: Int, tags: String, completion: @escaping (Result<[Photo], HttpProviderError>) -> Void) {
        let requestBuilder = RequestManagerHelper()
        fetch(endpoint:requestBuilder.photosPathBuilder(page: page, tags: tags)) { result in
            completion(result)
        }
    }

    func getPhotoSizes(photo: Photo, completion: @escaping (Result<[Size], HttpProviderError>) -> Void) {
        let requestBuilder = RequestManagerHelper()
        fetch(endpoint:requestBuilder.photoSizePathBuilder(id: photo.id)) { result in
            completion(result)
        }
    }

    func getImage(sizeURL: Size, completion: @escaping (Result<UIImage?, HttpProviderError>) -> Void) {
        let imageUrlString = sizeURL.source
        guard let imageUrl:URL = URL(string: imageUrlString) else {
            return
        }

        DispatchQueue.global().async {
            if let imageData = try? Data(contentsOf: imageUrl) {
                completion(.success(UIImage(data: imageData)))
            }
        }
    }

    func getPhotoSizeURL(photo: Photo, sizeType: SizeType, completion: @escaping (Size?) -> ()) {
        self.getPhotoSizes(photo:photo) { result in
            switch result {
            case .success(let sizes):
                for size in sizes {
                    if size.label ==  sizeType.sizetype {
                        switch sizeType {
                        case .largeSquare:
                            completion(size)
                        case .large:
                            completion(size)
                        }
                    }
                }
            case .failure:
                completion(nil)
            }
        }
    }
}


