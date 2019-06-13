//
//  ViewController.swift
//  Connect Hub
//
//  Created by Saksham Chaudhary on 12/06/19.
//  Copyright © 2019 Saksham Chaudhary. All rights reserved.
//

import UIKit
import Firebase
class LoginViewController: UIViewController {

    
    @IBOutlet weak var userNameTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    
    @IBOutlet weak var LoginBtn: UIButton!
    
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
    
    @IBAction func loginBtnTapped(_ sender: Any) {
        
        Auth.auth().signIn(withEmail: userNameTxtField.text!, password: passwordTxtField.text!) { (user, error) in
            if error == nil{
                print("Success")
            }
            else{
                print("False")
            }
        }
        
    }
    
    
    
}

