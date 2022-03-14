//
//  ImageCacheServiceTests.swift
//  EmployeesAppTests
//
//  Created by Hugo Reyes on 3/11/22.
//

import XCTest
@testable import EmployeesApp


class ImageCacheServiceTests: XCTestCase {
    
    var sut : ImageCacheServiceMirror!
    let mockDownloadImageService = MockDownloadImageService()
    
    override func setUpWithError() throws {
        let imageCacheService = ImageCacheService(networkService: mockDownloadImageService)
        self.sut = ImageCacheServiceMirror(imageCacheService: imageCacheService)
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testImageIsBeingStoredInCacheAfterBeingDownloaded() throws {
        
        // 1. Create a dummy UIImage object that is supposed to be returned by the
        // downloadImageService
        let sampleImage = UIImage()
        
        // 2. The image is set as the response of the next `downloadImageFromUrl` call
        self.mockDownloadImageService.setResponse(result: .success(sampleImage))
        
        // 3. The cache service will then use the injected mockDownloadImageService
        // to make a the downloadImageFromUrl `request`.
        var result = false
        sut.imageCacheService.downloadImageFromUrl(url: "http://this-a-test") { data in
            guard let data = data else {
                return
            }
            
            // Obviously the expected result is the sampleImage is equal to the reponse
            if (sampleImage == data){
                result = true
            }
            
            XCTAssert(result)
        }
        
        // 4. Since the image that was download is supposed to be store in the private
        // cacheImage attribute in the ImageCacheService object, it is necessary then to
        // test/check if the image is present in it or not
        if (sut.cacheImage?.object(forKey: "http://this-a-test")) != nil{
            XCTAssert(true) // It means the image is stored in the cache. It passed the test.
        }else{
            XCTAssert(false) // Image was not store in the cache. It failed the test.
        }
        
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
