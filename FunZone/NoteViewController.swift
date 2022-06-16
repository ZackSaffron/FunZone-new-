//
//  NoteViewController.swift
//  FunZone
//
//  Created by admin on 6/3/22.
//

import UIKit

class NoteViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveNote(_ sender: Any) {
        didSelectSave()
    }
    
    func didSelectSave() {
        var title = textField.text!
        var isTitleCreated = DBHelper.dbHelper.checkTitle(title: title)
        if isTitleCreated {
            DBHelper.dbHelper.updateNote(title: title, body: textView.text!)
        }
        else {
            DBHelper.dbHelper.addData(titleValue: textField.text!, bodyValue: textView.text!)
        }
    }
    
    @IBAction func deleteNote(_ sender: Any) {
        DBHelper.dbHelper.deleteNote(title: textField.text!)
    }
    
}
