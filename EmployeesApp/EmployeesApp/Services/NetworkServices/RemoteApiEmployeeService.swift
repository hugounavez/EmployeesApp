//
//  NetworkEmployeeService.swift
//  EmployeesApp
//
//  Created by Hugo Reyes on 3/11/22.
//

import Foundation

protocol RemoteApiEmployeeServiceProtocol{
    func request(router: Router, completion: @escaping (Result<ResponseApi, Error>) -> ())
}

class RemoteApiEmployeeService : RemoteApiEmployeeServiceProtocol{
    func request(router: Router, completion: @escaping (Result<ResponseApi, Error>) -> ()) {
        GenericNetworkService.request(router: router, completion: completion)
    }
}
