//
//  SettingsVC.swift
//  QDCCustomerApp
//
//  Created by Maahi on 07/07/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {

    @IBOutlet weak var settingTableView: UITableView!
    
    var settingArray = ["Notifications", "My Profile", "Default Payment Method", "Feedback", "Call Us", "Share"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    
    

}


extension SettingsVC{
    static func getStoryboardInstance() -> UINavigationController?{
        let storyborad = UIStoryboard(name: String(describing: self), bundle: nil)
        guard let navViewController = storyborad.instantiateInitialViewController()  as? UINavigationController else { return nil }
        return navViewController
    }
}


extension SettingsVC:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let settingCell = tableView.dequeueReusableCell(withIdentifier: "CELL") as UITableViewCell?
        settingCell?.textLabel?.text = settingArray[indexPath.row]
        return settingCell!
    }
}

extension SettingsVC:UITableViewDelegate{
    
    
    
    
}
