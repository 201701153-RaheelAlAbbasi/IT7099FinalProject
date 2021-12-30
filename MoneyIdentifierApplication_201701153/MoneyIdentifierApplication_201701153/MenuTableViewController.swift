//
//  MenuTableViewController.swift
//  MoneyIdentifierApplication_201701153
//
//  Created by Raheel AlAbbasi on 30/12/2021.
//

import UIKit

class MenuTableViewController: UIViewController {

    @IBOutlet var menuTable: UITableView!
    
    let menuArray = ["Scanner" , "In-App Settings","Device App Settings","Contact Us"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        menuTable.delegate = self
        menuTable.dataSource = self
        // Do any additional setup after loading the view.
    }
    
}

extension MenuTableViewController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let segueIdentifier: String
            switch indexPath.row {
            case 0: //For 1
                 segueIdentifier = "menuToScanner"
            case 1: //For 2
                segueIdentifier = "menuToSettings"
                
            case 2: //For 3
                
                segueIdentifier = "menuToScanner"
                if let url = URL(string:UIApplication.openSettingsURLString)

                { if UIApplication.shared.canOpenURL(url)
                { UIApplication.shared.open(url, options: [:], completionHandler: nil)

                }
                }
                
            default: //For "last"
                 segueIdentifier = "menuToContact"
            }
            self.performSegue(withIdentifier: segueIdentifier, sender: self)
        

    }
}

extension MenuTableViewController : UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath)
        cell.textLabel?.text = menuArray[indexPath.row]
        return cell
    }
    
    
}

