//
//  Employee.swift
//  EmployeesApp
//
//  Created by Hugo Reyes on 3/5/22.
//

import Foundation

struct Employee : Codable {
    let uuid : String?
    let fullName : String?
    let phoneNumber: String?
    let emailAddress: String?
    let biography : String?
    let photoUrlSmall : String?
    let photoUrlLarge : String?
    let team : String?
    let employeeType : String?
    
    enum CodingKeys: String, CodingKey {
        case uuid
        case fullName = "full_name"
        case phoneNumber = "phone_number"
        case emailAddress = "email_address"
        case biography
        case photoUrlSmall = "photo_url_small"
        case photoUrlLarge = "photo_url_large"
        case team
        case employeeType = "employee_type"
    }
}

struct ResponseApi : Codable {
    let employees : [Employee]
}
