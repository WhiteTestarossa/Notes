//
//  NoteViewController.swift
//  Notes
//
//  Created by Daniel Belokursky on 24.03.22.
//

import UIKit

protocol NoteViewControllerDelegate: AnyObject {
    func didFinishEdditingNote()
    func didCancelNote(id: UUID)
}

class NoteViewController: UIViewController {

    //MARK: - Properties
    let textView = UITextView()
    let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dismissKeyboard))
    var note: Note?
    weak var delegate: NoteViewControllerDelegate?
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.largeTitleDisplayMode = .never
        self.navigationItem.rightBarButtonItem = doneButton
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        self.view.backgroundColor = .white
        
     
        NotificationCenter.default.addObserver(self, selector: #selector(updateTextView(notification:)), name: UIResponder.keyboardDidChangeFrameNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateTextView(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        configureTextView()
        getNote()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let text = self.textView.text, text.isEmpty {
            textView.becomeFirstResponder()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if self.isMovingFromParent {
            if let note = note {
                if !note.text.isEmpty {
                    note.date = Date()
                    CoreDataManager.shared.save()
                    delegate?.didFinishEdditingNote()
                } else {
                    delegate?.didCancelNote(id: note.id)
                    CoreDataManager.shared.deleteNote(note: note)
                }
            }
        }
    }

    //MARK: - Methods
    @objc func dismissKeyboard() {
        textView.resignFirstResponder()
        self.navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    //MARK: Note
    func getNote() {
        if let note = note {
            textView.text = note.text
        }
    }
    
    //MARK: Prevent Keyboard Covering
    @objc func updateTextView(notification: Notification) {
        let userInfo = notification.userInfo
        if let keybordSize = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if notification.name == UIResponder.keyboardWillHideNotification {
                textView.contentInset = UIEdgeInsets.zero
            } else {
                textView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keybordSize.height, right: 0)
            }
        }
    }

    //MARK: - TextView Setup
    func configureTextView() {
        self.textView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(textView)
        self.textView.delegate = self
        self.textView.font = UIFont.preferredFont(forTextStyle: .body)
        self.textView.textContentType = .none
        self.textView.autocapitalizationType = .sentences
        
        
        NSLayoutConstraint.activate([
            self.textView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.textView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.textView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.textView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

    //MARK: - TextView Delegate Methods
extension NoteViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        self.navigationItem.rightBarButtonItem?.isEnabled = true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        note?.text = textView.text
    }
    
}
