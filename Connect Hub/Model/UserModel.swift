//
//  UserModel.swift
//  Connect Hub
//
//  Created by Saksham Chaudhary on 17/06/19.
//  Copyright © 2019 Saksham Chaudhary. All rights reserved.
//

import Foundation

enum role {
    case admin
    case student
    case teacher
}

public class UserModel{
    
    var name : String
    var emailID : String
    var contactNo : Int
    var city : String
    var dob : String
    var userRole : role
    

    init(name: String, emailID : String, contactNo : Int, city : String, dob : String, userRole : role) {
        self.name = name
        self.emailID = emailID
        self.contactNo = contactNo
        self.city = city
        self.dob = dob
        self.userRole = userRole
    }
}
