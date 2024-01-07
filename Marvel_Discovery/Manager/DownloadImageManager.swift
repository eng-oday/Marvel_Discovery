//
//  DownloadImageManager.swift
//  Marvel_Discovery
//
//  Created by eng-oday on 07/01/2024.
//

import Foundation
import UIKit
import RxSwift

protocol ImageLoaderActions: AnyObject {
    func loadRemoteImageFrom(urlString: String) -> Single<UIImage>
}

final class ImageLoader: ImageLoaderActions {
    func loadRemoteImageFrom(urlString: String) -> Single<UIImage> {
        guard let url = URL(string: urlString) else {return Single.error(ImageLoadingError.invalidURL)}
        
        return Single.create { single in
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let resultImageData = data , let img = UIImage(data: resultImageData) {
                        single(.success(img))
                    } else {
                        single(.failure(ImageLoadingError.failedToLoadImage))
                    }
                }
                task.resume()
                return Disposables.create()
            }
            
        }
    }
