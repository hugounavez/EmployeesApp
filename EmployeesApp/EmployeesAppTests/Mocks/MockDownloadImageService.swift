//
//  MockDownloadImageService.swift
//  EmployeesAppTests
//
//  Created by Hugo Reyes on 3/13/22.
//

import XCTest
@testable import EmployeesApp


class MockDownloadImageService : DownloadImageServiceProtocol {
    
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
