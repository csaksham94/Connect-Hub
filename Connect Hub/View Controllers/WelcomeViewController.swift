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
    
    @IBOutlet weak var welcomeLabel: UILabel!
    
    @IBOutlet weak var passwordField: UITextField!
    
    
    var name = ""
    var emailID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tapGesture()
        makeNavBarTransparent()
        userLabel.text = "\(emailID)"
        print(emailID)
        welcomeLabel.text = "\(name)"

        // Do any additional setup after loading the view.
    }
    

    @IBAction func letsGoBtnTapped(_ sender: Any) {
        
        Auth.auth().createUser(withEmail: emailID, password: passwordField.text!) { (user, error) in
            if error == nil{
                print("Success")
            }
            else {
                print("Fail")
            }
        }
        
        
        
        
      // self.dismiss(animated: true, completion: nil)
        
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
