//
//  MainViewModelTests.swift
//  EmployeesAppTests
//
//  Created by Hugo Reyes on 3/9/22.
//

import XCTest
import Combine
@testable import EmployeesApp



class MainViewModelTests: XCTestCase {
    
    
    var viewModel: HomeViewModel!
    let mockRemoteApiEmployeeService = MockRemoteApiEmployeeService()
    
    var bag : Set<AnyCancellable> = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
        
        let imageCacheService = ImageCacheService(networkService: DownloadImageService())
        self.viewModel = HomeViewModel(mockRemoteApiEmployeeService, imageCacheService: imageCacheService)
        
    }
    
    func testEmployeeRequestWithSucessResponse(){
        
        let employee = Employee(uuid: "1", fullName: "Bad bunny", phoneNumber: "12345", emailAddress: "messi@gmail.com", biography: "I am an employee", photoUrlSmall: "", photoUrlLarge: "", team: "", employeeType: "")
        let responseApi = ResponseApi(employees: [employee])

        self.mockRemoteApiEmployeeService.injectClousureForTest(result: .success(responseApi))
        self.viewModel.getEmployees()
        
        self.viewModel.data.sink { result in
            if (employee.uuid == result[0].uuid){
                XCTAssert(true)
            }
        }.store(in: &bag)
        
    }
    
    
    func testEmployeeRequestWithErrorResponse(){
        self.mockRemoteApiEmployeeService.injectClousureForTest(result: .failure(NSError(domain: "", code: 0, userInfo: ["": ""])))
        self.viewModel.getEmployees()
        
        var result = false
        self.viewModel.$error.sink { _ in
            result = true
            XCTAssert(result)
        }.store(in: &bag)
    }
    
    
    
}
