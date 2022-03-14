//
//  ImageCacheServiceMirror.swift
//  EmployeesAppTests
//
//  Created by Hugo Reyes on 3/13/22.
//

import XCTest
@testable import EmployeesApp

class ImageCacheServiceMirror : MirrorObject {
    
    var imageCacheService: ImageCacheServiceProtocol
    
    init(imageCacheService: ImageCacheServiceProtocol){
        self.imageCacheService = imageCacheService
        super.init(reflecting: imageCacheService)
    }
    
    // For every property that needs to be expose for the unit tests
    // it has to be create it like the following:
    var cacheImage: NSCache<NSString, UIImage>? {
        extract() // This makes the `cacheImage` available
    }
}
