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
        configureStackView()
        
        titlesStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titlesStackView)
        
        NSLayoutConstraint.activate([
            titlesStackView.leadingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.leadingAnchor),
            titlesStackView.topAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.topAnchor),
            titlesStackView.trailingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.trailingAnchor),
            titlesStackView.bottomAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.bottomAnchor)
        ])
    }
    
    //MARK: - StackView Setup
    func configureStackView() {
        titlesStackView.addArrangedSubview(titleLabel)
        titlesStackView.addArrangedSubview(descriptionLabel)
        titlesStackView.axis = .vertical
        titlesStackView.distribution = .fill
        titlesStackView.alignment = .fill
        titlesStackView.spacing = 4.0
    }
    
    //MARK: - Titles Setup
    func configureTitleLabel() {
        titleLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        titleLabel.lineBreakMode = .byTruncatingTail
        
        descriptionLabel.font = UIFont.preferredFont(forTextStyle: .body)
        descriptionLabel.lineBreakMode = .byTruncatingTail
        descriptionLabel.textColor = .lightGray
    }
    
}
