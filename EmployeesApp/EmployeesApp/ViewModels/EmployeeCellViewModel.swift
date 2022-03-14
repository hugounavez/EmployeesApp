//
//  EmployeeCellViewModel.swift
//  EmployeesApp
//
//  Created by Hugo Reyes on 3/8/22.
//

import Foundation
import UIKit

class EmployeeCellViewModel{
    var imageCacheService : ImageCacheServiceProtocol
    
    init(imageCacheService : ImageCacheServiceProtocol){
        self.imageCacheService = imageCacheService
    }
    
    func fetchImage(url: String, completion: @escaping (UIImage?)->()){
        self.imageCacheService.downloadImageFromUrl(url: url, completion: completion)
    }
}
