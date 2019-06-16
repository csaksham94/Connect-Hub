//
//  UnableToLoginViewController.swift
//  Connect Hub
//
//  Created by Saksham Chaudhary on 16/06/19.
//  Copyright © 2019 Saksham Chaudhary. All rights reserved.
//

import UIKit

class UnableToLoginViewController: UIViewController {

    @IBOutlet weak var cancelBtn: UIBarButtonItem!
    
    
    
    
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
