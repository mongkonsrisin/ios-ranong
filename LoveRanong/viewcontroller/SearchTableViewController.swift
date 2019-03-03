//
//  SearchTableViewController.swift
//  LoveRanong
//
//  Created by Lapp on 27/2/2561 BE.
//  Copyright © 2561 Ranong. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController ,UIPickerViewDataSource, UIPickerViewDelegate   {

    @IBOutlet weak var startDateTextField: UITextField!
    @IBOutlet weak var endDateTextField: UITextField!
    @IBOutlet weak var catTextField: UITextField!
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var budgetTextField: UITextField!
    @IBOutlet weak var peopleTextField: UITextField!
    
    var datePicker:UIDatePicker!
    var catPicker: UIPickerView = UIPickerView()
    var typePicker: UIPickerView = UIPickerView()
    
    var catArray:[String] = ["ทั้งหมด","เชิงนิเวศ","เชิงสุขภาพ"]
    var typeArray:[String] = ["ทั้งหมด","รถยนต์","มอเตอร์ไซค์","จักรยาน"]


    
    @IBAction func doSearch(_ sender: Any) {
        
        if(startDateTextField.text == "" || endDateTextField.text == "" || catTextField.text == "" || typeTextField.text == "" ||
            budgetTextField.text == "" || peopleTextField.text == "") {
            let title = "ข้อผิดพลาด"
            let message = "กรุณากรอกข้อมูลให้ครบ"
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
        } else {
            performSegue(withIdentifier: "segueSearchResult", sender: nil)
        }
        
    }
    
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "segueSearchResult") {
            if let destinationViewController = segue.destination as? SearchResultViewController {
                destinationViewController.datestart = startDateTextField.text!
                destinationViewController.dateend = endDateTextField.text!
                switch (catTextField.text!) {
                case "ทั้งหมด" :                 destinationViewController.category = 0
                break
                case "เชิงนิเวศ" :                 destinationViewController.category = 1
                break
                case "เชิงสุขภาพ" :                 destinationViewController.category = 2
                break
                default : destinationViewController.category = 0
                break
                    
                }
            
                switch (typeTextField.text!) {
                case "ทั้งหมด" :                 destinationViewController.type = 0
                    break
                case "รถยนต์" :                 destinationViewController.type = 1
                    break
                case "มอเตอร์ไซค์" :                 destinationViewController.type = 2
                    break
                case "จักรยาน" :                 destinationViewController.type = 2
                    break
                default : destinationViewController.type = 0
                    break
                    
                }
                destinationViewController.budget = Int(budgetTextField.text!)!
                destinationViewController.people = Int(peopleTextField.text!)!
                
            }
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    @IBAction func showDatePicker(_ sender: UITextField) {
        datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.calendar = Calendar(identifier: .buddhist)
        datePicker.locale = Locale(identifier: "th")
        sender.inputView = datePicker
        let toolBar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 0, height: 44))
        toolBar.barStyle = UIBarStyle.default
       let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelTapped))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneTapped))
        
        toolBar.items = [cancelButton, flexibleSpace, doneButton]
        sender.inputAccessoryView = toolBar
        
    }
    
    
    
    @IBAction func showDatePicker2(_ sender: UITextField) {
        datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.calendar = Calendar(identifier: .buddhist)
        datePicker.locale = Locale(identifier: "th")
        sender.inputView = datePicker
        let toolBar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 0, height: 44))
        toolBar.barStyle = UIBarStyle.default
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelTapped2))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneTapped2))
        
        toolBar.items = [cancelButton, flexibleSpace, doneButton]
        sender.inputAccessoryView = toolBar
    }
    
    
    
    
    @objc func doneTapped(sender:UIBarButtonItem!) {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "th")
        dateFormatter.setLocalizedDateFormatFromTemplate("yyyy-MM-dd")
        startDateTextField.text = dateFormatter.string(from: datePicker.date)
        startDateTextField.resignFirstResponder()
    }
    
    
    @objc func cancelTapped(sender:UIBarButtonItem!) {
        startDateTextField.resignFirstResponder()
    }
    
    
    
  
    @objc func cancelTappedCat(sender:UIBarButtonItem!) {
        catTextField.resignFirstResponder()
    }
   
    @objc func cancelTappedType(sender:UIBarButtonItem!) {
        typeTextField.resignFirstResponder()
    }
    
    
    @objc func doneTapped2(sender:UIBarButtonItem!) {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "th")
        dateFormatter.setLocalizedDateFormatFromTemplate("yyyy-MM-dd")
        endDateTextField.text = dateFormatter.string(from: datePicker.date)
        endDateTextField.resignFirstResponder()
    }
    
    @objc func cancelTapped2(sender:UIBarButtonItem!) {
        endDateTextField.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        catPicker.dataSource = self
        catPicker.delegate = self
        
        typePicker.dataSource = self
        typePicker.delegate = self
        
        catTextField.inputView = catPicker
        typeTextField.inputView = typePicker
        
        catTextField.text = "ทั้งหมด"
        typeTextField.text = "ทั้งหมด"
        
        let toolBarCat: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 0, height: 44))
        toolBarCat.barStyle = UIBarStyle.default
        let toolBarType: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 0, height: 44))
        toolBarCat.barStyle = UIBarStyle.default
        toolBarType.barStyle = UIBarStyle.default

        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButtonCat = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(cancelTappedCat))
     
        let doneButtonType = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(cancelTappedType))
        
        
        toolBarCat.items = [flexibleSpace, doneButtonCat]
       catTextField.inputAccessoryView = toolBarCat
        
        toolBarType.items = [flexibleSpace, doneButtonType]
        typeTextField.inputAccessoryView = toolBarType
        
        
    
       
    }

    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView == catPicker) {
            return catArray.count
        }
        if (pickerView == typePicker) {
            return typeArray.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pickerView == catPicker) {
            return catArray[row]
        }
        if (pickerView == typePicker) {
            return typeArray[row]
        }
        return ""
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (pickerView == catPicker) {
            catTextField.text = catArray[row]
        }
        if (pickerView == typePicker) {
            typeTextField.text = typeArray[row]
        }
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    


}
