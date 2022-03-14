//
//  NetworkLayer.swift
//  EmployeesApp
//
//  Created by Hugo Reyes on 3/5/22.
//

import Foundation


class GenericNetworkService {
    
    static func request<T : Decodable>(router: Router, completion: @escaping (Result<T, Error>) -> ()){
        
        var components = URLComponents()
        components.scheme = router.sheme
        components.host = router.host
        components.path = router.path
        components.queryItems = router.queryParameters
        
        guard let url = components.url else {
            return
        }
        
        let urlSession = URLSession(configuration: .default)
        
        urlSession.dataTask(with: url) { data, response, error in
            
            guard error == nil else{
                completion(.failure(error!))
                return
            }
            
            guard let data = data else {
                return
            }
            
            guard let response = response as? HTTPURLResponse, 200..<300 ~= response.statusCode else {
                let error = NSError(domain: "", code: 401, userInfo: [ NSLocalizedDescriptionKey: "Please, check your internet connection or contact the server admin"])
                return completion(.failure(error as NSError))
            }
        
            do {
                let dataObject = try JSONDecoder().decode(T.self, from: data)
                completion(.success(dataObject))
            }catch(let error){
                completion(.failure(error))
            }
            
        }.resume()
        
        
    }
    

    
}




