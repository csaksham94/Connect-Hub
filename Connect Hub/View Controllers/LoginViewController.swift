//
//  ViewController.swift
//  Connect Hub
//
//  Created by Saksham Chaudhary on 12/06/19.
//  Copyright © 2019 Saksham Chaudhary. All rights reserved.
//

import UIKit
import Firebase
import ARSLineProgress

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var userNameTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var LoginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tapGesture()
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
        ARSLineProgress.show()
        Auth.auth().signIn(withEmail: userNameTxtField.text!, password: passwordTxtField.text!) { (user, error) in
            if error == nil{
                ARSLineProgress.hide()
                print("Success")
                self.performSegue(withIdentifier: "goToLogin" , sender: self)
            }
            else{
                print(error!)
                print("False")
                let alert = UIAlertController(title: "Login Error", message: "Please check the email ID/Password entered.!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                    print("Fail OK pressed")
                }))
                ARSLineProgress.hide()
                self.present(alert, animated: true, completion: nil)
            }
        }
        
    }
    
    
    
}

