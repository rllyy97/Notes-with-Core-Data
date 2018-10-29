//
//  SingleViewController.swift
//  Notes with Core Data
//
//  Created by Riley Evans on 10/29/18.
//  Copyright © 2018 Riley Evans. All rights reserved.
//

import UIKit

class SingleViewController: UIViewController {
    
    @IBOutlet weak var editTitle: UITextField!
    @IBOutlet weak var editBody: UITextView!
    @IBOutlet weak var date: UILabel!
    
    var currentNote: Note?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editTitle.text = currentNote?.title
        editBody.text = currentNote?.body
        editBody.layer.borderWidth = 0.3
        editBody.layer.borderColor = UIColor.lightGray.cgColor
        editBody.layer.cornerRadius = 5
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let myString = formatter.string(from: Date())
        let myDate = formatter.date(from: myString)
        formatter.dateFormat = "MMMM dd, yyyy"
        let dateString = formatter.string(from: myDate!)
        date.text = "Created on " + dateString
        
    }
    
    @IBAction func save(_ sender: Any) {
        
        let title = editTitle.text
        let body = editBody.text
        let date = Date.init()
        
        var note: Note?
        
        if let currentNote = currentNote {
            currentNote.title = title
            currentNote.body = body
            currentNote.date = date
            note = currentNote
        } else {
            note = Note(title: title, body: body, date: date)
        }
        
        if let note = note {
            do {
                let managedContext = note.managedObjectContext
                try managedContext?.save()
                self.navigationController?.popViewController(animated: true)
                print("Successfully Saved")
            } catch {
                print("Context could not be saved")
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
