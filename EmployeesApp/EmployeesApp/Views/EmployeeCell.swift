//
//  EmployeeCell.swift
//  EmployeesApp
//
//  Created by Hugo Reyes on 3/5/22.
//

import UIKit

class EmployeeCell: UITableViewCell {
    static let identifier = "EmployeeCell"
    
    let mainImage : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "person.fill")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let nameLabel : UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let teamLabel : UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var labelsStack : UIStackView = {
        let stack = UIStackView(arrangedSubviews: [self.nameLabel, self.teamLabel])
        stack.distribution = .fillEqually
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupCustomLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCustomLayout(){
        self.setupMainImageLayout()
        self.setupLabelsLayout()
    }
    
    func setupMainImageLayout(){
        self.backgroundColor = .clear
        self.addSubview(self.mainImage)
        
        NSLayoutConstraint.activate([self.mainImage.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 10),
                                     self.mainImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                                     self.mainImage.heightAnchor.constraint(equalToConstant: 80),
                                     self.mainImage.widthAnchor.constraint(equalToConstant: 80)])
        
        self.mainImage.clipsToBounds = true
        self.mainImage.layer.cornerRadius = 10
    }
    
    func setupLabelsLayout(){
        self.addSubview(self.labelsStack)
        NSLayoutConstraint.activate([self.labelsStack.leftAnchor.constraint(equalTo: self.mainImage.rightAnchor, constant:  16),
                                     self.labelsStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
                                     self.labelsStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
                                     self.labelsStack.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5)])
    }
    
    var viewModel : EmployeeCellViewModel!
    func initializeViewModel(viewModel: EmployeeCellViewModel){
        self.viewModel = viewModel
    }
    
    func setDataInCell(model: Employee){
        self.nameLabel.text = ""
        self.teamLabel.text = ""
        
        if let fullName = model.fullName {
            self.nameLabel.text = "Name: " + fullName
        }
        
        if let team = model.team {
            self.teamLabel.text = "Team: " + team
        }
        
        guard let photoUrlSmall = model.photoUrlSmall else{
            return
        }
        
        self.viewModel?.fetchImage(url: photoUrlSmall, completion: { [weak self] image in
            guard let image = image else {
                return
            }
            DispatchQueue.main.async {
                self?.mainImage.image = image
            }
        })
    }
}
