//
//  NetworkFetcherImageService.swift
//  EmployeesApp
//
//  Created by Hugo Reyes on 3/8/22.
//

import UIKit

protocol DownloadImageServiceProtocol
{
    func downloadImage(urlString: String, completion: @escaping (Result<UIImage, Error>) -> ())
}


class DownloadImageService : DownloadImageServiceProtocol {
    
    func downloadImage(urlString: String, completion: @escaping (Result<UIImage, Error>) -> ()){
        
        let urlSession = URLSession(configuration: .default)
        
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        urlSession.dataTask(with: url) { data, response, error in
            
            guard error == nil else{
                completion(.failure(error!))
                return
            }
            
            guard let data = data else {
                return
            }
            
            guard let response = response as? HTTPURLResponse, 200..<300 ~= response.statusCode else {
                return completion(.failure(NSError()))
            }
            
            if let image = UIImage(data: data){
                    completion(.success(image))
                }else{
                    let error = NSError(domain: "", code: 401, userInfo: [ NSLocalizedDescriptionKey: "Error casting data to image"])
                    completion(.failure(error))
            }
            
        }.resume()
    }
}

