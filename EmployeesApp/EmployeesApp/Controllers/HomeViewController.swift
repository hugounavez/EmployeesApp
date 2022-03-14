//
//  HomeViewController.swift
//  EmployeesApp
//
//  Created by Hugo Reyes on 3/5/22.
//

import UIKit
import Combine

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Properties
    var mainView : HomeView = HomeView()
    private let viewModel : HomeViewModel
    var data : [Employee] = [] // Data that is being shown by the tableView
    private var bag : Set<AnyCancellable> = Set<AnyCancellable>()
    
    // MARK: - Methods
    init(viewModel: HomeViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    deinit {
        print("HomeViewController disposed")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(self.mainView)
        NSLayoutConstraint.activate([self.mainView.topAnchor.constraint(equalTo: self.view.topAnchor),
                                     self.mainView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
                                     self.mainView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
                                     self.mainView.rightAnchor.constraint(equalTo: self.view.rightAnchor)])
        self.mainView.setupCustomLayout()
        
        self.navigationController?.navigationBar.topItem?.title = "Employee App"
        self.mainView.setupCustomLayout()
        self.setupTableView()
        self.bindErrorWithUIAlerts()
        self.getEmployees()
        
    }
    
    func bindErrorWithUIAlerts(){
        // It shows an altert if an error from the server is received
        self.viewModel.$error.sink {[weak self] error in
            DispatchQueue.main.async {
                self?.mainView.tableView.refreshControl?.endRefreshing()
            }
            
            guard !error.isEmpty else {return}
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Network error", message: error, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self?.present(alert, animated: true, completion: nil)
            }
            
        }.store(in: &bag)
    }
    
    func bindViewModelDataToTableView(){
        self.viewModel.$data.sink { [weak self] result in
            self?.data = result
            DispatchQueue.main.async {
                self?.mainView.tableView.reloadData()
                self?.mainView.tableView.refreshControl?.endRefreshing()
            }
            
        }.store(in: &bag)
    }
    
    func setupTableView(){
        self.mainView.tableView.backgroundColor = .systemBackground
        self.mainView.tableView.delegate = self
        self.mainView.tableView.dataSource = self
        self.mainView.tableView.register(EmployeeCell.self, forCellReuseIdentifier: EmployeeCell.identifier)
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(getEmployees), for: .valueChanged)
        self.mainView.tableView.refreshControl = refreshControl
        
        self.bindViewModelDataToTableView()
    }
    
    @objc func getEmployees(){
        self.mainView.tableView.refreshControl?.beginRefreshing()
        self.viewModel.getEmployees()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EmployeeCell.identifier, for: indexPath) as! EmployeeCell
        let viewModel = EmployeeCellViewModel(imageCacheService: self.viewModel.imageCacheService)
        cell.initializeViewModel(viewModel: viewModel)
        cell.setDataInCell(model: self.data[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

