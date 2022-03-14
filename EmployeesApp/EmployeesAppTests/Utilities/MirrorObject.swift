//
//  MirrorObject.swift
//  EmployeesAppTests
//
//  Created by Hugo Reyes on 3/13/22.
//

import Foundation

class MirrorObject {
    // This classes was extracted by the following article:
    // https://digitalbunker.dev/how-to-test-private-methods-variables-in-swift/
    
    // The clear intention was to use reflection in order to access to private
    // attributes for unit testing.
    
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

