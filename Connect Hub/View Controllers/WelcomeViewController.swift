//
//  WelcomeViewController.swift
//  Connect Hub
//
//  Created by Saksham Chaudhary on 12/06/19.
//  Copyright © 2019 Saksham Chaudhary. All rights reserved.
//

import UIKit
import Firebase

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var letsGoBtn: UIButton!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var unmatchPasswordLbl: UILabel!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var passwordCheckField: UITextField!
    
    var name = ""
    var emailID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tapGesture()
        makeNavBarTransparent()
        configPageDisplay()

    }
    
    
    func configPageDisplay(){
        
        userLabel.text = "\(emailID)"
        print(emailID)
        welcomeLabel.text = "\(name)"
        
    }
    
    @IBAction func letsGoBtnTapped(_ sender: Any) {
        
        
        if passwordField.text == passwordCheckField.text{
            unmatchPasswordLbl.isHidden = true
            sendingCredToFirebase(userName: userLabel.text!, pass: passwordCheckField.text!)
            
        } else {
            unmatchPasswordLbl.isHidden = false
            
        }
        
    }
    
    func sendingCredToFirebase(userName : String, pass : String){
        
        Auth.auth().createUser(withEmail: userName, password: pass) { (user, error) in
            if error == nil{
                print("Success")
                let alert = UIAlertController(title: "Registration Successful", message: "Please continue to login..!!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                    self.dismiss(animated: true, completion: nil)
                }))
                self.present(alert, animated: true, completion: nil)
            }
            else {
                print("Fail")
                let alert = UIAlertController(title: "Registration Error", message: "Please check the email ID entered.!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                    print("Fail OK pressed")
                }))
                self.present(alert, animated: true, completion: nil)
                
            }
        }
        
        
    }
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    func tapGesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(WelcomeViewController.viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    func makeNavBarTransparent(){
        navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        
    }
    
    
}
