//
//  HelperFile.swift
//  Connect Hub
//
//  Created by Saksham Chaudhary on 16/06/19.
//  Copyright © 2019 Saksham Chaudhary. All rights reserved.
//

import Foundation
import ARSLineProgress

public class CommonHelper {
  
    func commonAlert(title : String, msg : String){
        
        let alert = UIAlertController(title: "Reset Email sent Successfully", message: "Please check your Email ID..!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            print("Fail OK pressed")
        }))
        ARSLineProgress.hide()
        
        
        
    }
    
}
