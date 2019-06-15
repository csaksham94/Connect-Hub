//
//  NewUserViewController.swift
//  Connect Hub
//
//  Created by Saksham Chaudhary on 12/06/19.
//  Copyright © 2019 Saksham Chaudhary. All rights reserved.
//

import UIKit

class NewUserViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var nameTxtField: UITextField!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var contactTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var dobTxtField: UITextField!
    @IBOutlet weak var rolePicker: UIPickerView!
    
    var userRole = ""
    private var dobPicker : UIDatePicker?
    var roleArray = ["Student", "Teacher", "Admin"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeNavBarTransparent()
        tapGesture()
        setUpDOBPicker()
    }
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    func tapGesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(NewUserViewController.viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
    }
    func makeNavBarTransparent(){
        navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "newUserToWelcome"{
            let secondVC = segue.destination as! WelcomeViewController
            secondVC.name = nameTxtField.text!
            secondVC.emailID = emailTxtField.text!
            
        }
    }
    //Picker Functions
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return roleArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        userRole = roleArray[row]
        return roleArray[row]
    }
    
    
    private func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView!) -> UIView {
        
        var pickerLabel = view as? UILabel;
        if (pickerLabel == nil)
        {
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont(name: "Montserrat", size: 16)
            pickerLabel?.textAlignment = NSTextAlignment.center
            pickerLabel?.textColor = UIColor(red: 3, green: 253, blue: 236, alpha: 1)
        }
        
        pickerLabel?.text = roleArray[row]
        return pickerLabel!;
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let titleData = roleArray[row]
        let myTitle = NSAttributedString(string: titleData, attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(displayP3Red: 3, green: 253, blue: 236, alpha: 1)])
        return myTitle
    }
    
    func setUpDOBPicker(){
        
        dobPicker = UIDatePicker()
        dobPicker?.datePickerMode = .date
        dobTxtField.inputView = dobPicker
        dobPicker?.addTarget(self, action: #selector(NewUserViewController.dobChanged(dobPicker:)), for: .valueChanged)
        
    }
    
    @objc func dobChanged(dobPicker : UIDatePicker){
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        dobTxtField.text = dateFormatter.string(from: dobPicker.date)
        
        
    }
    
}
