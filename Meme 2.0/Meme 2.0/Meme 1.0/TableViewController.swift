//
//  TableViewController.swift
//  Meme 1.0
//
//  Created by Ebraham Alskaf on 25/03/2024.
//

import UIKit

class tableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: Model
    
    var memes: [Meme] {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
    // MARK: View LIfe Cycle
    
    override func viewDidLoad() {
         super.viewDidLoad()
     }


    // MARK: Table View Data Source Methods
    
    // number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return self.memes.count
    }

    // cell for row at index path
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell")!
        
        let meme = self.memes[(indexPath as NSIndexPath).row]
    
        
        return cell

    }
}
