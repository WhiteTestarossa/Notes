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
//            Note(text: "Cafe Deadend", location:"Hong Kong"),
//            Note(text: "Homei", location: "Hong Kong"),
//            Note(text: "Teakha", location: "Hong Kong"),
//            Note(text: "Cafe loisl", location: "Hong Kong"),
//            Note(text: "Petite Oyster", location: "Hong Kong"),
//            Note(text: "For Kee Note", location: "HongKong"),
//            Note(text: "Po's Atelier", location: "Hong Kong"),
//            Note(text: "Bourke Street Backery", location:"Sydney"),
//            Note(text: "Haigh's Chocolate", location: "Sydney"),
//            Note(text: "Palomino Espresso", location: "Sydney"),
//            Note(text: "Upstate", location: "New York"),
//            Note(text: "Traif", location: "New York"),
//            Note(text: "Graham Avenue Meats", location: "New York"),
//            Note(text: "Waffle & Wolf", location: "NewYork"),
//            Note(text: "Five Leaves", location: "New York"),
//            Note(text: "Cafe Lore", location: "New York"),
//            Note(text: "Confessional", location: "New York"),
//            Note(text: "Barrafina", location: "London"),
//            Note(text: "Donostia", location: "London"),
//            Note(text: "Royal Oak", location: "London"),
//            Note(text: "CASK Pub and Kitchen", location: "London")
        ]
    
    //MARK: - ViewController Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Notes"
        
        configureTableView()
        configureFooterView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("ViewWillAppear")
        let selectedIndexPath = self.tableView.indexPathForSelectedRow
        if let indexPath = selectedIndexPath {
            self.tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    private func indexForNote(id: UUID, in list: [Note]) -> IndexPath {
        let row = Int(list.firstIndex(where: { $0.id == id }) ?? 0)
        return IndexPath(row: row, section: 0)
    }
    
    //MARK: - TableView Setup
    func configureTableView() {
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = 80.0
        self.tableView.separatorStyle = .none
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
        
        footerView.createButton.addTarget(self, action: #selector(createNotePressed), for: .touchUpInside)

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
    
    //MARK: - Create New Note
    @objc func createNotePressed() {
        let newNote = Note()
        notes.insert(newNote, at: 0)
        
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        
        let noteViewController = NoteViewController()
        noteViewController.note = newNote
        noteViewController.delegate = self
        
        navigationController?.pushViewController(noteViewController, animated: true)
    }
}

    //MARK: - TableView Delegate and Data Source Methods
extension NoteListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath) as! NoteTableViewCell
        cell.titleLabel.text = notes[indexPath.row].text
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let noteViewController = NoteViewController()
        noteViewController.note = notes[indexPath.row]
        noteViewController.delegate = self
        navigationController?.pushViewController(noteViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            notes.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
}

    //MARK: - NoteViewController Delegate Methods
extension NoteListViewController: NoteViewControllerDelegate {
    func didFinishEdditingNote() {
        self.navigationController?.popViewController(animated: true)
        tableView.reloadData()
    }
    
    func didCancelNote(id: UUID) {
        self.navigationController?.popViewController(animated: true)
        let indexPath = indexForNote(id: id, in: notes)
        notes.remove(at: indexPath.row)
        DispatchQueue.main.async { [weak self] in
            self?.tableView.beginUpdates()
            self?.tableView.deleteRows(at: [indexPath], with: .fade)
            self?.tableView.endUpdates()
        }
    }
}


