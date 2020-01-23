//
//  AppleViewController.swift
//  TestDelegate
//
//  Created by raskin-sa on 11/01/2020.
//  Copyright © 2020 raskin-sa. All rights reserved.
//

import UIKit

protocol AppleViewControllerDelegate: class {
    func fruitDidSelect(_ fruit: String)
}

class AppleViewController: UITableViewController {
    
    let apple = ["Яблоко", "Персик", "Киви"]
    
     weak var delegate: AppleViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return apple.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AppleCell", for: indexPath)
        cell.textLabel?.text = apple[indexPath.row]
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
              let fruit = apple[indexPath.row]
         delegate?.fruitDidSelect(fruit)
         dismiss(animated: true, completion: nil)
    }
}//class AppleViewController

