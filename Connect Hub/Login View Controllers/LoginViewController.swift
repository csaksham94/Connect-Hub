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

class LoginViewController: BaseViewController {
    
    
    @IBOutlet weak var userNameTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var LoginBtn: UIButton!
    
    var ref : DatabaseReference?
    var databaseHandle : DatabaseHandle?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tapGesture()
        LoginBtn.layer.cornerRadius = 10
        
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
                        self.gettingDataFromFirebase()
            }
            else{
                print(error!)
                print("False")
                self.commonErrorfunction(title: "Login Error", msg: "Please check the email ID/Password entered.!")
                
            }
        }
        
    }
    
    func gettingDataFromFirebase(){
        
        let db = Firestore.firestore()
        let docRef = db.collection("users").document(self.userNameTxtField.text!)
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                print("Document data: \(dataDescription)")
                ARSLineProgress.hide()
                print("Success")
                self.performSegue(withIdentifier: "goToLogin" , sender: self)
            } else {
                print("Document does not exist")
            }
        }
        
        
    }
    
}
