//
//  HomeViewModel.swift
//  EmployeesApp
//
//  Created by Hugo Reyes on 3/5/22.
//

import Combine

protocol MainViewModelProtocol {
    func getEmployees()
}

class HomeViewModel : MainViewModelProtocol{

    var remoteApiEmployeeService : RemoteApiEmployeeServiceProtocol
    var imageCacheService : ImageCacheServiceProtocol
    
    init(_ remoteApiEmployeeService : RemoteApiEmployeeServiceProtocol,
         imageCacheService: ImageCacheServiceProtocol){
        self.remoteApiEmployeeService = remoteApiEmployeeService
        self.imageCacheService = imageCacheService
    }
    
    //var data : CurrentValueSubject<[Employee], Never> = CurrentValueSubject<[Employee], Never>([Employee]())
    @Published var data : [Employee] = []
    @Published var error : String = ""
    
    func getEmployees() {
      
        remoteApiEmployeeService.request(router: .getEmployees) {[weak self] (result: Result<ResponseApi, Error>) in
            switch result {
            case .success(let data):
                self?.data = data.employees
            case.failure(let error):
                self?.error = error.localizedDescription
                break
            }
        }
    }
    
}
