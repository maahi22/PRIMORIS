//
//  ProfileVC.swift
//  QDCCustomerApp
//
//  Created by Maahi on 07/07/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {

    @IBOutlet var profileClient:ProfileClient!
    
    
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

        self.setupUI()
        //self.automaticallyAdjustsScrollViewInsets = false
    }

    func setupUI() {
        
        self.userImageView.layer.cornerRadius = self.userImageView.frame.size.height/2
        self.updateButton.setTitleColor(COLOUR_ON_BUTTON, for: UIControlState.normal)
        self.updateButton.backgroundColor = BUTTON_COLOUR
        self.nameTextField.text = QDCUserDefaults.getUserName()
        self.emailTextField.text = QDCUserDefaults.getUserEmail()
        self.mobileTextField.text = QDCUserDefaults.getUserMobile()
        self.addressTextField.text = QDCUserDefaults.getUserAddress()
        self.updateButton.layer.cornerRadius = 10
        
    }
    
    
    func hitUpdateUserWebService() {
        
        profileClient.updateProfile(areaLocation: self.pickupAddressTextField.text!, name: self.nameTextField.text!, address: self.addressTextField.text!) {  [weak self] (isSuccess, message)  in
            
            guard let strongSelf = self else{return}
            //  strongSelf.dismissLoadingHUD()
           /* if isSuccess{
                DispatchQueue.main.async {
                    showAlertMessage(vc: strongSelf, title: .Error, message: message)
                }
                
            }else{
                showAlertMessage(vc: strongSelf, title: .Error, message: message)
            }*/
            
            
        }
    }

}

extension ProfileVC{
    static func getStoryboardInstance() -> UINavigationController?{
        let storyborad = UIStoryboard(name: String(describing: self), bundle: nil)
        guard let navViewController = storyborad.instantiateInitialViewController()  as? UINavigationController else { return nil }
        return navViewController
    }
}
