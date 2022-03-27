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
    
    var notes: [Note] = [] {
        didSet {
            footerView.countLabel.text = "\(notes.count == 0 ? "No Notes" : (notes.count == 1) ? "1 Note" : " \(notes.count) Notes")"
            tableView.separatorStyle = notes.count == 0 ? .none : .singleLine
        }
    }
    
    let cellIdentifier = "CellId"
    
    //MARK: - ViewController Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Notes"
        
        configureTableView()
        configureFooterView()
        fetchNotes()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let selectedIndexPath = self.tableView.indexPathForSelectedRow
        if let indexPath = selectedIndexPath {
            self.tableView.deselectRow(at: indexPath, animated: true)
        }
        
    }
    
    //MARK: - TableView Setup
    func configureTableView() {
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = 80.0
        self.tableView.separatorStyle = .none
        
        self.view.addSubview(tableView)
        self.tableView.register(NoteTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        
        NSLayoutConstraint.activate([
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
    }
    
    //MARK: Footer for TableView Setup
    func configureFooterView() {
        footerView.countLabel.text = String(notes.count)
        
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
        let newNote = CoreDataManager.shared.createNote()
        notes.insert(newNote, at: 0)
        
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        
        let noteViewController = NoteViewController()
        noteViewController.note = newNote
        noteViewController.delegate = self
        
        navigationController?.pushViewController(noteViewController, animated: true)
    }
    
    //MARK: - Load All Notes
    func fetchNotes() {
        notes = CoreDataManager.shared.fetch()
    }
    
}

//MARK: - TableView Delegate and Data Source Methods
extension NoteListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! NoteTableViewCell
        
        cell.titleLabel.text = notes[indexPath.row].title
        cell.descriptionLabel.text = notes[indexPath.row].desc
        
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
            CoreDataManager.shared.deleteNote(note: notes[indexPath.row])
            
            tableView.beginUpdates()
            notes.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
}

//MARK: - NoteViewController Delegate Methods
extension NoteListViewController: NoteViewControllerDelegate {
    func didFinishEdditingNote(note: Note) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func didCancel(note: Note) {
        let index = Int(notes.firstIndex(where: {$0.id == note.id}) ?? 0)
        let indexPath = IndexPath(row: index, section: 0)
        
        notes.remove(at: index)
        DispatchQueue.main.async {
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}


