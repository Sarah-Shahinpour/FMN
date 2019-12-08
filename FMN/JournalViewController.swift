//
//  JournalViewController.swift
//  FMN
//
//  Created by Sarah Shahinpour on 11/25/19.
//  Copyright © 2019 Sarah Shahinpour. All rights reserved.
//

import UIKit

class JournalViewController: UITableViewController, AddJournalEntryViewControllerDelegate {
    
    let CellIdentifier = "Cell Identifier"
    
    var journalEntries = [JournalEntry]()
    
    //MARK: Initialization
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        
        //Load Journal Entries
        loadJournalEntries()
    }
    
    //MARK: Add Journal Entry View Controller Delegate Methods
    func controller(controller: AddJournalEntryViewController, didSaveJournalEntryWithDate date: String, andEntry entry: String) {
        
        // Create Journal Entry
        let journalEntry = JournalEntry(date: date, entry: entry)
        
        // Add Journal Entry to Journal Entries
        journalEntries.append(journalEntry)
        
        // Add Row to Table View
        tableView.insertRows(at: [(NSIndexPath(row: (journalEntries.count - 1), section: 0) as IndexPath)], with: UITableView.RowAnimation.none)
    }
    
    //MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddJournalEntryViewController" {
            if let navigationController = segue.destination as? UINavigationController, let addJournalEntryViewController = navigationController.viewControllers.first as? AddJournalEntryViewController {
                addJournalEntryViewController.delegate = self
            }
        }
        if let destination = segue.destination as? DisplayJournalEntryViewController {
            destination.journalEntry = journalEntries[(tableView.indexPathForSelectedRow?.row)!]
        }
    }
    
    
    
    //MARK: Helper Methods
    //https://stackoverflow.com/questions/53347426/ios-editor-bug-archiveddata-renamed
    private func loadJournalEntries(){
        let fullPath = getDocumentsDirectory().appendingPathComponent("journalEntries.plist")
//        if let filePath = pathForJournalEntries(), FileManager.default.fileExists(atPath: filePath) {
//            if let archivedJournalEntries = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? [JournalEntry] {
//                journalEntries = archivedJournalEntries
//            }
//        }
        if let nsData = NSData(contentsOf: fullPath) {
            do {
                let data = Data(referencing:nsData)

                if let loadedJournalEntries = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? Array<JournalEntry> {
                    journalEntries = loadedJournalEntries
                }
            } catch {
                print("Couldn't read file.")
            }
        }
    }
    
    
//    private func pathForJournalEntries() -> String? {
//        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
//        if let documents = paths.first, let documentsURL = NSURL(string: documents) {
//            return documentsURL.appendingPathComponent("journalEntries.plist")?.path
//        }
//        return nil
//    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    private func saveItems() {
        let fullPath = getDocumentsDirectory().appendingPathComponent("journalEntries.plist")
        do {
            let filePath = try NSKeyedArchiver.archivedData(withRootObject: journalEntries, requiringSecureCoding: true)
            try filePath.write(to:fullPath)
        } catch {
            print(error)
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Journal Entries"
        
        // Register Class
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: CellIdentifier)
        
        // Create Add Button
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addJournalEntry(sender:)))
        

    }
    
    @objc func addJournalEntry(sender: UIBarButtonItem) {
        //print("Button was tapped. (;")
        performSegue(withIdentifier: "AddJournalEntryViewController", sender: self)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return journalEntries.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier, for: indexPath)

        // Fetch Journal Entry
        let journalEntry = journalEntries[indexPath.row]
        
        // Configure Table View Cell
        cell.textLabel?.text = journalEntry.date

        return cell
    }
    
    override func tableView(_ tableView: UITableView,didSelectRowAt indexPath: IndexPath){
        //tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "showJournalEntry", sender: self)
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
 
    */

    

}
