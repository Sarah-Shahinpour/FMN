//
//  AddJournalEntryViewController.swift
//  FMN
//
//  Created by Sarah Shahinpour on 11/27/19.
//  Copyright © 2019 Sarah Shahinpour. All rights reserved.
//

import UIKit

protocol AddJournalEntryViewControllerDelegate {
    func controller(controller: AddJournalEntryViewController, didSaveJournalEntryWithDate date: String, andEntry entry: String)
}

class AddJournalEntryViewController: UIViewController {
    
    @IBOutlet var dateTextField: UITextField!
    @IBOutlet var entryTextField: UITextField!
    
    var delegate: AddJournalEntryViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: Actions
    @IBAction func cancel(sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func save(sender: UIBarButtonItem) {
        if let date = dateTextField.text, let entry = entryTextField.text{
            //Notify Delegate
            delegate?.controller(controller: self, didSaveJournalEntryWithDate: date, andEntry: entry)
            
            //Dismiss View Controller
            dismiss(animated: true, completion: nil)
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
