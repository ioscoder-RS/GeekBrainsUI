//
//  CustomSegue.swift
//  GeekbrainsUI
//
//  Created by raskin-sa on 21/12/2019.
//  Copyright © 2019 raskin-sa. All rights reserved.
//

import UIKit

class CustomSegue: UIStoryboardSegue{
    override func perform() {
        guard let customContainer = source.view.superview else {return}
    
    
        customContainer.addSubview(destination.view)
    
        destination.view.alpha = 0
        
        UIView.animate(withDuration: 1.0, animations: {self.destination.view.alpha = 1.0 }) { completion in self.source.present(self.destination, animated: false, completion: nil)
        }
    }//func perform
}//class
