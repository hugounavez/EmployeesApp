//
//  ImageCacheService.swift
//  EmployeesApp
//
//  Created by Hugo Reyes on 3/8/22.
//

import UIKit

protocol ImageCacheServiceProtocol {
    func downloadImageFromUrl(url: String, completion: @escaping (UIImage?) -> ())
}

class ImageCacheService : ImageCacheServiceProtocol{
    var cacheImage : NSCache<NSString, UIImage> = NSCache<NSString, UIImage>()

    var networkService: DownloadImageServiceProtocol
    init(networkService: DownloadImageServiceProtocol){
        self.networkService = networkService
    }
    
    
    func downloadImageFromUrl(url: String, completion: @escaping (UIImage?) -> ()){
        // Check if the imate is being
        if let image = cacheImage.object(forKey: url as NSString){
            completion(image)
            return
        }
        
        let currentUrlRequest = url
        
        self.networkService.downloadImage(urlString: url) { [weak self] result in
            switch result {
            case .success(let image):
                
                if (url == currentUrlRequest){
                    // save image in cache
                    print("from cache")
                    self?.cacheImage.setObject(image, forKey: url as NSString)
                    completion(image)
                }else{
                    print("didn't match")
                }
            case .failure(_):
                completion(nil)
            }
        }
    }
}
