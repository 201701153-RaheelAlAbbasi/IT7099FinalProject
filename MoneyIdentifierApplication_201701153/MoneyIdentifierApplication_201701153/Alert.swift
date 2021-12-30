//
//  Alert.swift
//  MoneyIdentifierApplication_201701153
//
//  Created by Raheel AlAbbasi on 30/12/2021.
//

import Foundation

class Alert :  {
    
    func createAlertOne(title : String, message : String) {
        let alertVar = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        //Creating 1 button
        alertVar.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: { (action) in
            alertVar.dismiss(animated: true, completion: nil)
            
            
        }))
        self.present(alertVar, animated: true, completion: nil)
    }
}
