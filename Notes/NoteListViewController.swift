//
//  ViewController.swift
//  Notes
//
//  Created by Daniel Belokursky on 23.03.22.
//

import UIKit

class NoteListViewController: UIViewController {

    //MARK: - Properties
    var tableView = UITableView()
    let footerView = FooterView()
    
    var notes: [Note] = [
            Note(name: "Cafe Deadend", location:"Hong Kong"),
            Note(name: "Homei", location: "Hong Kong"),
            Note(name: "Teakha", location: "Hong Kong"),
            Note(name: "Cafe loisl", location: "Hong Kong"),
            Note(name: "Petite Oyster", location: "Hong Kong"),
            Note(name: "For Kee Note", location: "HongKong"),
            Note(name: "Po's Atelier", location: "Hong Kong"),
            Note(name: "Bourke Street Backery", location:"Sydney"),
            Note(name: "Haigh's Chocolate", location: "Sydney"),
            Note(name: "Palomino Espresso", location: "Sydney"),
            Note(name: "Upstate", location: "New York"),
            Note(name: "Traif", location: "New York"),
            Note(name: "Graham Avenue Meats", location: "New York"),
            Note(name: "Waffle & Wolf", location: "NewYork"),
            Note(name: "Five Leaves", location: "New York"),
            Note(name: "Cafe Lore", location: "New York"),
            Note(name: "Confessional", location: "New York"),
            Note(name: "Barrafina", location: "London"),
            Note(name: "Donostia", location: "London"),
            Note(name: "Royal Oak", location: "London"),
            Note(name: "CASK Pub and Kitchen", location: "London")
        ]
    
    //MARK: - ViewController Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Notes"
        
        configureTableView()
        configureFooterView()
    }
    
    //MARK: - TableView Setup
    func configureTableView() {
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = 80.0
        self.view.addSubview(tableView)
        self.tableView.register(NoteTableViewCell.self, forCellReuseIdentifier: "CellId")
        
        NSLayoutConstraint.activate([
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    //MARK: Footer for TableView Setup
    func configureFooterView() {
        let blurEffect = UIBlurEffect(style: .regular)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        
        visualEffectView.translatesAutoresizingMaskIntoConstraints = false
        footerView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.insertSubview(visualEffectView, at: 1)
        self.view.addSubview(footerView)

        NSLayoutConstraint.activate([
            footerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            footerView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            footerView.heightAnchor.constraint(equalToConstant: 50.0),
            
            visualEffectView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            visualEffectView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            visualEffectView.topAnchor.constraint(equalTo: self.footerView.topAnchor),
            visualEffectView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
}

    //MARK: - TableView Delegate and Data Source Methods
extension NoteListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath) as! NoteTableViewCell
        cell.titleLabel.text = notes[indexPath.row].name
        cell.descriptionLabel.text = notes[indexPath.row].location
        return cell
    }
}


