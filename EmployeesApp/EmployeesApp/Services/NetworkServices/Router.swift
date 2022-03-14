//
//  Router.swift
//  EmployeesApp
//
//  Created by Hugo Reyes on 3/5/22.
//

import Foundation

enum Router {
    case getEmployees
    case getErrorEmployeesEmpty
    case getErrorEmployeesMalformed
    
    // 2. Scheme
    var sheme : String {
        switch self {
        case .getEmployees, .getErrorEmployeesEmpty, .getErrorEmployeesMalformed:
            return "https"
        }
    }
    
    // 2. Host
    var host: String {
        switch self {
        case .getEmployees, .getErrorEmployeesEmpty, .getErrorEmployeesMalformed:
            return "s3.amazonaws.com"
        }
    }
    
    // path
    var path : String {
        switch self {
        case .getEmployees:
            return "/sq-mobile-interview/employees.json"
        case .getErrorEmployeesEmpty:
            return "/sq-mobile-interview/employees_empty.json"
        case .getErrorEmployeesMalformed:
            return "/sq-mobile-interview/employees_malformed.json"
        }
    }
    
    // In case I need query parameters:
    var queryParameters: [URLQueryItem] {
        switch self {
        case .getEmployees, .getErrorEmployeesEmpty, .getErrorEmployeesMalformed:
            return []
        }
    }
    
    // In case I need really specify the http method:
    var method: String {
        switch self  {
        case .getEmployees, .getErrorEmployeesEmpty, .getErrorEmployeesMalformed:
            return "GET"
        }
    }
    
}
