//
//  NoteTableViewCell.swift
//  Notes
//
//  Created by Daniel Belokursky on 23.03.22.
//

import UIKit

class NoteTableViewCell: UITableViewCell {

    //MARK: - Properties
    var titleLabel = UILabel()
    var descriptionLabel = UILabel()
    var titlesStackView = UIStackView()
    
    //MARK: - Initilizer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - TableViewCell Setup
    func configureCell() {
        configureTitleLabel()
        configureDescriptionLabel()
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20.0),
            titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20.0),
            titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10.0),
            titleLabel.bottomAnchor.constraint(equalTo: self.descriptionLabel.topAnchor, constant: 5.0),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20.0),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20.0),
            descriptionLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 10.0),
        ])
    }
    
    //MARK: - Titles Setup
    func configureTitleLabel() {
        titleLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        titleLabel.lineBreakMode = .byTruncatingTail
        titleLabel.numberOfLines = 1
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    //MARK: - Description Setup
    func configureDescriptionLabel() {
        descriptionLabel.font = UIFont.preferredFont(forTextStyle: .body)
        descriptionLabel.lineBreakMode = .byTruncatingTail
        descriptionLabel.textColor = .lightGray
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
}
