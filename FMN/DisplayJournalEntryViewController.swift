//
//  DisplayJournalEntryViewController.swift
//  FMN
//
//  Created by Sarah Shahinpour on 12/7/19.
//  Copyright © 2019 Sarah Shahinpour. All rights reserved.
//

import UIKit

class DisplayJournalEntryViewController: UIViewController {
    
    @IBOutlet var date: UILabel!
    @IBOutlet var entry: UITextView!
    
    var journalEntry: JournalEntry?

    override func viewDidLoad() {
        super.viewDidLoad()
        date.text = journalEntry?.date
        entry.text = journalEntry?.entry

        // Do any additional setup after loading the view.
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
