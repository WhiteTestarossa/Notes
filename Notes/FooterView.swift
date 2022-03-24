//
//  FooterView.swift
//  Notes
//
//  Created by Daniel Belokursky on 24.03.22.
//

import UIKit

class FooterView: UIView {
    
    //MARK: - Properties
    let countLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.textColor = UIColor.lightGray
        label.text = "0 Notes"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let createButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "square.and.pencil"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    //MARK: - Initilizer
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup View
    func configureView() {
        self.addSubview(countLabel)
        self.addSubview(createButton)
        
        NSLayoutConstraint.activate([
            countLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            countLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            createButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            createButton.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
            createButton.heightAnchor.constraint(equalToConstant: 50.0),
            createButton.widthAnchor.constraint(equalToConstant: 50.0)
        ])
    }
    
}
