//
//  ViewController.swift
//  TestDelegate
//
//  Created by raskin-sa on 11/01/2020.
//  Copyright © 2020 raskin-sa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var labelView: UILabel!
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toFruit" {
            let ctrl = segue.destination as! AppleViewController
            ctrl.delegate = self
        }
    }
}

extension ViewController: AppleViewControllerDelegate {
    
    func fruitDidSelect(_ fruit: String) {
        labelView.text = fruit
    }
    
}
