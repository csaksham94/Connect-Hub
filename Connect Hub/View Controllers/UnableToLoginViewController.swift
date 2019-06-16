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

class UnableToLoginViewController: UIViewController {

    @IBOutlet weak var cancelBtn: UIBarButtonItem!
    
    @IBOutlet weak var emailIDTxtField: UITextField!
    
    @IBOutlet weak var resetBtn: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeNavBarTransparent()

        // Do any additional setup after loading the view.
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
                let alert = UIAlertController(title: "Reset Email sent Successfully", message: "Please check your Email ID..!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                    print("Fail OK pressed")
                }))
                ARSLineProgress.hide().self
                self.present(alert, animated: true, completion: nil)
                
            
        
            }
            else {
                print("Fail with Error : \(String(describing: error))")
                let alert = UIAlertController(title: "Reset Email Failed", message: "Please check your Email ID..!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                    print("Fail OK pressed")
                }))
                ARSLineProgress.hide()
                self.present(alert, animated: true, completion: nil)
               
            }
        }
        
        
    }

}
