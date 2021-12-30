//
//  ContactUsViewController.swift
//  MoneyIdentifierApplication_201701153
//
//  Created by Raheel AlAbbasi on 30/12/2021.
//

import UIKit
import MessageUI

class ContactUsViewController: UIViewController, MFMailComposeViewControllerDelegate {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func sendEmailButton(_ sender: Any) {
        sendEmail()
    }
    
    
    @IBAction func callButton(_ sender: Any) {
        phoneCall()
    }
    
    
    
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mailVar = MFMailComposeViewController()
            mailVar.mailComposeDelegate = self
            mailVar.setToRecipients(["201701153@student.polytechnic.bh"])
            mailVar.setMessageBody("", isHTML: true)

            present(mailVar, animated: true)
        } else {
            createAlertOne(title: "Error", message: "You don't have Mail option on your device")
        }
    }

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    
    
    func phoneCall(){
        let phoneURL:NSURL = NSURL(string: "tel://97339323930")!
    
    //Deprecated, find alternative for future use
    UIApplication.shared.openURL(phoneURL as URL)
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

