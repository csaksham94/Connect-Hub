//
//  UnableToLoginViewController.swift
//  Connect Hub
//
//  Created by Saksham Chaudhary on 16/06/19.
//  Copyright © 2019 Saksham Chaudhary. All rights reserved.
//

import UIKit
import Firebase
import ARSLineProgress

class UnableToLoginViewController: BaseViewController {
    
    @IBOutlet weak var cancelBtn: UIBarButtonItem!
    @IBOutlet weak var emailIDTxtField: UITextField!
    @IBOutlet weak var resetBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeNavBarTransparent()
       
    }
    
    func makeNavBarTransparent(){
        navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        
    }
    
    @IBAction func cancelBtnTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func resetBtnTapped(_ sender: Any) {
        ARSLineProgress.show()
        Auth.auth().sendPasswordReset(withEmail: emailIDTxtField.text!) { (error) in
            if error == nil{
                print("Success")
                
                self.commonErrorfunction(title: "Reset Email sent Successfully", msg: "Please check your Email ID..!")
                
                
                
            }
            else {
                print("Fail with Error : \(String(describing: error))")
                
                
                self.commonErrorfunction(title: "Reset Email Failed", msg: "Please check your Email ID..!")
                
            }
        }
        
        
    }
    
}
