//
//  TwoViewController.swift
//  TestDelegate
//
//  Created by raskin-sa on 11/01/2020.
//  Copyright © 2020 raskin-sa. All rights reserved.
//

import UIKit

class TwoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var labelView: UILabel!
        
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier == "toFruit2" {
            let ctrl = segue.destination as! AppleViewController
            ctrl.delegate = self
        }
    }
    
}

extension TwoViewController: AppleViewControllerDelegate {
    
    func fruitDidSelect(_ fruit: String) {
        labelView.text = fruit
    }
    
}
