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
        configureStackView()
        
        contentView.addSubview(titlesStackView)
        titlesStackView.addArrangedSubview(titleLabel)
        titlesStackView.addArrangedSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            titlesStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20.0),
            titlesStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10.0),
            titlesStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20.0),
            titlesStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10.0),
        ])
    }
    
    //MARK: - StackView Setup
    func configureStackView() {
        titlesStackView.axis = .vertical
        titlesStackView.distribution = .fillEqually
        titlesStackView.translatesAutoresizingMaskIntoConstraints = false
        titlesStackView.spacing = 4.0
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
