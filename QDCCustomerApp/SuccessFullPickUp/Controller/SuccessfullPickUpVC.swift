//
//  SuccessfullPickUpVC.swift
//  QDCCustomerApp
//
//  Created by Maahi on 07/07/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import UIKit

class SuccessfullPickUpVC: UIViewController,CancelReasonDelegate {

    @IBOutlet private var schedulePickUpDateClient:SchedulePickUpDateClient!
    @IBOutlet private var sheduledDropOffClient:SheduledDropOffClient!
    
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
        navigationItem.setHidesBackButton(true, animated: true)
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
        navigationController?.popViewController(animated: true)
        /*if self.dropOffOrderId.isEmpty { //drop of id will only exist in case the user has drop off order
            
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
        }*/
    }
    
    @IBAction func cancelButtonClick(_ sender: Any) {
    
        
        guard let navViewController = CancelReasonVC.getStoryboardInstance(),
            let viewController = navViewController.topViewController as? CancelReasonVC
            else { return  }
        viewController.cancelOrderdelegate = self 
        self.present(navViewController, animated: true, completion: {})
    }
    
    @IBAction func dashboardButtonClick(_ sender: Any) {
     navigationController?.popToRootViewController(animated: true)
        
    }

    
    
    
    //Delegate Methods
    func didSelectCancelReason(_ cancelReason:String) {
        print("delegate cancel")
        if self.dropOffOrderId.isEmpty { //drop of id will only exist in case the user has drop off order
            self.hitCancelPickupWebService(cancelReason)
        }else{
            self.hitCancelDropOffWebService(cancelReason)
        }
    }
    
    
    
    
    func hitCancelPickupWebService(_ cancelReason:String){
        
        schedulePickUpDateClient.getSchedulePickup(pickupDate: self.selectedPickupDate, pickupTime: self.selectedPickupTime, flag: 3, pickupNumber: self.pickUpOrderId, expressDeliveryID: "", specialInstruction: "", dropOffDate: "", dropOffTime: "", cancelReason: cancelReason) { [weak self](schedulePickUpModel, message) in
            guard let strongSelf = self else{return}
            if let schedulePickUpModel = schedulePickUpModel {
                
                
                var message = ""
                if schedulePickUpModel.Status == "Done" {
                    message = "Pick up successfully cancelled"
                }else{
                    message = "Something went wrong please try again later"
                }
                
                showAlertMessage(vc: strongSelf, title: .Message, message: message)
                
                
            }else{
                showAlertMessage(vc: strongSelf, title: .Error, message: "Something went wrong please try again later")
            }
        }
        
    }
    
    
      func hitCancelDropOffWebService(_ cancelReason:String){
        
        sheduledDropOffClient.getScheduleDropOff(dropOffDate: self.selectedDropOffDate, dropOffTime: self.selectedDropOffTime, flag: 3, pickupNumber: "", bookingNo: "", dropOffNumber: self.dropOffOrderId, cancelReason: cancelReason) {[weak self] (scheduleDropOffModel, message) in
            
            guard let strongSelf = self else{return}
            
            if let scheduleDropOffModel = scheduleDropOffModel {
                
                
                var message = ""
                if scheduleDropOffModel.Status == "Done" {
                    message = "Pick up successfully cancelled"
                }else{
                    message = "Something went wrong please try again later"
                }
                
                showAlertMessage(vc: strongSelf, title: .Message, message: message)
                
                
            }else{
                showAlertMessage(vc: strongSelf, title: .Error, message: "Something went wrong please try again later")
            }
            
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
