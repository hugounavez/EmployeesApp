//
//  MainView.swift
//  EmployeesApp
//
//  Created by Hugo Reyes on 3/5/22.
//

import UIKit
import Combine

class HomeView : UIView {
    
    // MARK: - Properties
    let tableView : UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    func setupCustomLayout() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.tableView)
        NSLayoutConstraint.activate([self.tableView.topAnchor.constraint(equalTo: self.topAnchor),
                                     self.tableView.leftAnchor.constraint(equalTo: self.leftAnchor),
                                     self.tableView.rightAnchor.constraint(equalTo: self.rightAnchor),
                                     self.tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)])
    }
}

