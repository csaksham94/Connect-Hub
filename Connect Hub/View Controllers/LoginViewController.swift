//
//  ViewController.swift
//  Connect Hub
//
//  Created by Saksham Chaudhary on 12/06/19.
//  Copyright © 2019 Saksham Chaudhary. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tapGesture()
        
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    func tapGesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
    }
}

