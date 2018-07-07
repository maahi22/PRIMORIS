//
//  ProfileVC.swift
//  QDCCustomerApp
//
//  Created by Maahi on 07/07/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {

    @IBOutlet weak var userImageView:UIImageView!
    @IBOutlet weak var nameTextField:UITextField!
    @IBOutlet weak var emailTextField:UITextField!
    @IBOutlet weak var mobileTextField:UITextField!
    @IBOutlet weak var addressTextField:UITextField!
    @IBOutlet weak var pickupAddressTextField:UITextField!
    @IBOutlet weak var updateButton: UIButton!
    @IBOutlet weak var ubdateBottomConstraint:NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    

}

extension ProfileVC{
    static func getStoryboardInstance() -> UINavigationController?{
        let storyborad = UIStoryboard(name: String(describing: self), bundle: nil)
        guard let navViewController = storyborad.instantiateInitialViewController()  as? UINavigationController else { return nil }
        return navViewController
    }
}
