//
//  NotesViewController.swift
//  Notes with Core Data
//
//  Created by Riley Evans on 10/29/18.
//  Copyright © 2018 Riley Evans. All rights reserved.
//

import UIKit
import CoreData

class NotesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var notes = [Note]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
        do {
            notes = try managedContext.fetch(fetchRequest)
            tableView.reloadData()
            print(notes.count)
            print("Data Reloaded")
        } catch {
            print("Fetch failed")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? SingleViewController,
            let selectedRow = self.tableView.indexPathForSelectedRow?.row else { return }
        destination.currentNote = notes[selectedRow]
    }
    
    func deleteNote(at indexPath: IndexPath) {
        let note = notes[indexPath.row]
        if let managedContext = note.managedObjectContext {
            managedContext.delete(note)
            do {
                try managedContext.save()
                self.notes.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            } catch {
                print("Delete Failed")
                tableView.reloadRows(at: [indexPath], with: .automatic)
            }
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let note = notes[indexPath.row]
        cell.textLabel?.text = note.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteNote(at: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return notes.count }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showNote", sender: self)
    }
}



    


