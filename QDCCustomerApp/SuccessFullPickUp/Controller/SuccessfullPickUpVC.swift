//
//  SuccessfullPickUpVC.swift
//  QDCCustomerApp
//
//  Created by Maahi on 07/07/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import UIKit

class SuccessfullPickUpVC: UIViewController,CancelReasonDelegate {

    
    @IBOutlet weak var messageLabel:UILabel!
    @IBOutlet weak var rescheduleButton:UIButton!
    @IBOutlet weak var cancelButton:UIButton!
    @IBOutlet weak var dashboardButton:UIButton!
    
    var message:String!
    var pickUpOrderId = ""
    var selectedPickupDate:String = ""
    var selectedPickupTime:String = ""
    
    var dropOffOrderId = ""
    var selectedDropOffDate:String = ""
    var selectedDropOffTime:String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
    }

    
    
    
    
    func setupUI() {
        
        self.messageLabel.textColor = TEXT_FIELD_COLOUR
        self.messageLabel.text = self.message
        
        /*self.rescheduleButton.setTitleColor(COLOUR_ON_BUTTON, for: UIControlState.normal)
        self.rescheduleButton.backgroundColor = BUTTON_COLOUR
 
        self.cancelButton.setTitleColor(COLOUR_ON_BUTTON, for: UIControlState.normal)
        self.cancelButton.backgroundColor = BUTTON_COLOUR
        
        self.dashboardButton.setTitleColor(COLOUR_ON_BUTTON, for: UIControlState.normal)
        self.dashboardButton.backgroundColor = BUTTON_COLOUR*/
        rescheduleButton.setButtonTheme()
        cancelButton.setButtonTheme()
        dashboardButton.setButtonTheme()
    }
    
    
    
    
   
    @IBAction func rescheduleButtonClick(_ sender: Any) {
    //TODO: check if its coming from pick up or drop off
        
        if self.dropOffOrderId.isEmpty { //drop of id will only exist in case the user has drop off order
            
            let navArray = self.navigationController?.viewControllers
            for  viewController in navArray! {
                
                if((viewController.isKind(of: PickUpDateVC.self)) == true) {
                    self.navigationController?.popToViewController(viewController as! PickUpDateVC, animated: true)
                    break;
                }
            }
            
        }else{
            
            let navArray = self.navigationController?.viewControllers
            for  viewController in navArray! {
                
                
                if((viewController.isKind(of: DropOffVC.self)) == true){
                    self.navigationController?.popToViewController(viewController as! DropOffVC, animated: true)
                    break;
                }
            }
        }
    }
    
    @IBAction func cancelButtonClick(_ sender: Any) {
    
        
        guard let navViewController = CancelReasonVC.getStoryboardInstance(),
            let viewController = navViewController.topViewController as? CancelReasonVC
            else { return  }
        viewController.cancelOrderdelegate = self 
        self.present(navViewController, animated: true, completion: {})
       // navigationController?.pushViewController(viewController, animated: true)
        
        
        
        /*let popup : CancelReasonVC = self.storyboard?.instantiateViewControllerWithIdentifier("QDCCancelReasonViewControllerID") as! QDCCancelReasonViewController
        popup.cancelOrderdelegate = self
        let navigationController = UINavigationController(rootViewController: popup)
        navigationController.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
        self.presentViewController(navigationController, animated: true, completion: nil)
        */
    }
    
    @IBAction func dashboardButtonClick(_ sender: Any) {
    
        
        guard let navViewController = DashboardVC.getStoryboardInstance(),
            let viewController = navViewController.topViewController as? DashboardVC
            else { return  }
        navViewController.isNavigationBarHidden = true
       // self.revealViewController().pushFrontViewController(navigationController, animated: true)
        
        
//        let controller = UIStoryboard.addDashBoardViewController() as QDCDashboardViewController
//        let navigationController = UINavigationController(rootViewController: controller)
//        navigationController.navigationBarHidden = true
        
    }

    
    
    
    //Delegate Methods
    func didSelectCancelReason(_ cancelReason:String) {
        print("delegate cancel")
        if self.dropOffOrderId.isEmpty { //drop of id will only exist in case the user has drop off order
            //self.hitCancelPickupWebService(cancelReason)
        }else{
            //self.hitCancelDropOffWebService(cancelReason)
        }
    }
    
    
    
    
}


extension SuccessfullPickUpVC{
    static func getStoryboardInstance() -> UINavigationController?{
        let storyborad = UIStoryboard(name: String(describing: self), bundle: nil)
        guard let navViewController = storyborad.instantiateInitialViewController()  as? UINavigationController else { return nil }
        return navViewController
    }
}
