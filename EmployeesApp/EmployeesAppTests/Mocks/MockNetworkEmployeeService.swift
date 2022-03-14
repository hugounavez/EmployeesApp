//
//  MockNetworkEmployeeService.swift
//  EmployeesAppTests
//
//  Created by Hugo Reyes on 3/11/22.
//

import XCTest
@testable import EmployeesApp

class MockNetworkEmployeeService : NetworkEmployeeServiceProtocol {
    
    var result : Result<ResponseApi, Error>?
    
    func injectClousureForTest(result: Result<ResponseApi, Error>){
        self.result = result
    }
    
    func request(router: Router, completion: @escaping (Result<ResponseApi, Error>) -> ()) {
        guard let result = result else {
            return
        }
        completion(result)
    }
    
}

