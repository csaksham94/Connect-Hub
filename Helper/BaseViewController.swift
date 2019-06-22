//
//  BaseViewController.swift
//  Connect Hub
//
//  Created by Saksham Chaudhary on 22/06/19.
//  Copyright © 2019 Saksham Chaudhary. All rights reserved.
//

import UIKit
import ARSLineProgress

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
    }
    
    func  commonErrorfunction(title : String, msg : String){
        
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            print("Fail OK pressed")
        }))
        ARSLineProgress.hide()
        self.present(alert, animated: true, completion: nil)
    }
}

