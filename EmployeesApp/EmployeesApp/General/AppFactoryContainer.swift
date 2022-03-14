//
//  AppFactoryContainer.swift
//  EmployeesApp
//
//  Created by Hugo Reyes on 3/8/22.
//

import Foundation

class AppFactoryContainer {
    
    static let shared = AppFactoryContainer()
    
    var remoteApiEmployeeService : RemoteApiEmployeeServiceProtocol = RemoteApiEmployeeService()
    
    static func makeHomeViewController() -> HomeViewController{
        let imageCacheService = ImageCacheService(networkService: DownloadImageService())
        let viewModel = HomeViewModel(AppFactoryContainer.shared.remoteApiEmployeeService, imageCacheService: imageCacheService)
        return HomeViewController(viewModel: viewModel)
    }
}
