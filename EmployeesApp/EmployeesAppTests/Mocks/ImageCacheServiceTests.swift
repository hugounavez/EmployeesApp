//
//  ImageCacheServiceTests.swift
//  EmployeesAppTests
//
//  Created by Hugo Reyes on 3/11/22.
//

import XCTest
@testable import EmployeesApp


class MirrorObject {
    // https://digitalbunker.dev/how-to-test-private-methods-variables-in-swift/
    
    let mirror: Mirror
    
    init(reflecting: Any) {
        mirror = Mirror(reflecting: reflecting)
    }
    
    func extract<T>(variableName: StaticString = #function) -> T? {
        extract(variableName: variableName, mirror: mirror)
    }
    
    private func extract<T>(variableName: StaticString, mirror: Mirror?) -> T? {
        guard let mirror = mirror else {
            return nil
        }
        
        guard let descendant = mirror.descendant("\(variableName)") as? T else {
            return extract(variableName: variableName, mirror: mirror.superclassMirror)
        }
        
        return descendant
    }
    
}


class ImageCacheServiceMirror : MirrorObject {
    
    var imageCacheService: ImageCacheServiceProtocol
    
    
    init(imageCacheService: ImageCacheServiceProtocol){
        self.imageCacheService = imageCacheService
        super.init(reflecting: imageCacheService)
        
        
    }
    
    // List all private properties you wish to test using SAME NAME.
    var cacheImage: NSCache<NSString, UIImage>? {
        extract()
    }
}


class MockNetworkFetcherImageService : NetworkFetcherImageServiceProtocol {
    
    var response : Result<UIImage, Error>?
    
    func setResponse(result: Result<UIImage, Error>){
        self.response = result
    }
    
    func downloadImage(urlString: String, completion: @escaping (Result<UIImage, Error>) -> ()) {
        guard let response = self.response else {
            return
        }
        completion(response)
    }
    
    
}


class ImageCacheServiceTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        
        let sampleImage = UIImage()
        let mockImageRemoteAPI = MockNetworkFetcherImageService()
        mockImageRemoteAPI.setResponse(result: .success(sampleImage))
        
        let imageCacheService = ImageCacheService(networkService: mockImageRemoteAPI)
        let sut = ImageCacheServiceMirror(imageCacheService: imageCacheService)
        
        var result = false
        sut.imageCacheService.downloadImageFromUrl(url: "http://this-a-test") { data in
            guard let data = data else {
                return
            }
            if (sampleImage == data){
                result = true
            }
            
            XCTAssert(result)
        }
        
        if (sut.cacheImage?.object(forKey: "http://this-a-test")) != nil{
            XCTAssert(true)
        }else{
            XCTAssert(false)
        }
        
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
