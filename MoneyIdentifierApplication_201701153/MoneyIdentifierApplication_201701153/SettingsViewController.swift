//
//  SettingsViewController.swift
//  MoneyIdentifierApplication_201701153
//
//  Created by Raheel AlAbbasi on 30/12/2021.
//

import UIKit

class SettingsViewController: UIViewController {

    
    let langs = ["Arabic", "English"]
    
    let currencies = ["Bahraini Dinars", "United Arab Emirates Dirhams"]
    
    @IBOutlet var langPicker: UIPickerView!
    
    @IBOutlet var currencyPicker: UIPickerView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        langPicker.delegate = self
        langPicker.dataSource = self
        currencyPicker.delegate = self
        currencyPicker.dataSource = self


}
    
  
}

extension SettingsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return langs.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return langs[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let currentLanguage = Locale.current.languageCode
        print("currentLanguage: \(currentLanguage ?? "")")
        let newLanguage = currentLanguage == "en" ? "ar" : "en"
        UserDefaults.standard.setValue([newLanguage], forKey: "Apple Languages")
        
        createAlertOne(title: "You changed the language", message: "The application must restart")
        
        //exit(0)
        
    }
    
    
    func createAlertOne(title : String, message : String) {
        let alertVar = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        //Creating 1 button
        alertVar.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: { (action) in
            alertVar.dismiss(animated: true, completion: nil)
            
            
        }))
        self.present(alertVar, animated: true, completion: nil)
    }
    
    
}

