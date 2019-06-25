//
//  LandingViewController.swift
//  Connect Hub
//
//  Created by Saksham Chaudhary on 23/06/19.
//  Copyright © 2019 Saksham Chaudhary. All rights reserved.
//

import UIKit

class LandingViewController: UIViewController {
    @IBOutlet weak var welcomeLbl: UILabel!
    
    var userDict = [String: Any].self
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeNavBarTransparent()

        // Do any additional setup after loading the view.
    }
    
    func makeNavBarTransparent(){
        tabBarController?.tabBar.isHidden = false
//self.tabBarController?.tabBar.backgroundImage(UIImage(), for: .default)
        self.tabBarController?.tabBar.shadowImage = UIImage()
        self.tabBarController?.tabBar.isTranslucent = true
        
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
