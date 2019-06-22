//
//  WelcomeViewController.swift
//  Connect Hub
//
//  Created by Saksham Chaudhary on 12/06/19.
//  Copyright © 2019 Saksham Chaudhary. All rights reserved.
//

import UIKit
import Firebase
import ARSLineProgress

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var letsGoBtn: UIButton!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var unmatchPasswordLbl: UILabel!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var passwordCheckField: UITextField!
    
    //userDict is set in NewUserViewController
    var userDict = [String : Any]()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tapGesture()
        makeNavBarTransparent()
        configPageDisplay()
        print(userDict)

    }
    
    
    func configPageDisplay(){
       
        userLabel.text = "\(String(describing: userDict["userEmail"]!))"

        welcomeLabel.text = "\(String(describing: userDict["username"]!))"
        
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
        ARSLineProgress.show()
        Auth.auth().createUser(withEmail: userName, password: pass) { (user, error) in
            if error == nil{
            
                self.storingDataToFirebase()
                print("Success")
                let alert = UIAlertController(title: "Registration Successful", message: "Please continue to login..!!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                    self.dismiss(animated: true, completion: nil)
                }))
                ARSLineProgress.hide()
                self.present(alert, animated: true, completion: nil)
            }
            else {
                print(error!)
                print("Fail")
                let alert = UIAlertController(title: "Registration Error", message: "Please check the email ID entered.!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                    print("Fail OK pressed")
                }))
                ARSLineProgress.hide()
                self.present(alert, animated: true, completion: nil)
                
            }
        }
        
        
    }
    
    
    func storingDataToFirebase(){
        
    
        var ref: DatabaseReference!
        ref = Database.database().reference()
          ref.child("users").child(userDict["username"]! as! String).setValue(userDict)
        
        
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
