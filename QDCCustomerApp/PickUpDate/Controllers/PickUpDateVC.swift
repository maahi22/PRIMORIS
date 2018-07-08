//
//  PickUpVC.swift
//  QDCCustomerApp
//
//  Created by Maahi on 06/07/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import UIKit

class PickUpDateVC: UIViewController {

    @IBOutlet private var pickUpDateViewModel:PickUpDateViewModel!
    @IBOutlet private var schedulePickUpDateClient:SchedulePickUpDateClient!
    
    @IBOutlet weak var timeSelectionCollectionView:UICollectionView!
    @IBOutlet weak var dateSelectionCollectionView:UICollectionView!
    @IBOutlet weak var specialInstructionTextView:UITextView!
    @IBOutlet weak var firstButton:UIButton!
    @IBOutlet weak var secondButton:UIButton!
    @IBOutlet weak var firstButtonRadioImage:UIImageView!
    @IBOutlet weak var secondButtonRadioImage:UIImageView!
    @IBOutlet weak var schedulePickupButton:UIButton!
    @IBOutlet weak var containerScrollView:UIScrollView!
    @IBOutlet weak var timeCollectionBottomConstraint:NSLayoutConstraint!
    
    var pickupNumber:String = ""
    var showDropOff:Bool = false
    var requireDropOff:Bool = false
    var selectedDate:String = ""
    var selectedTime:String = ""
    var pickUpScheduleArray:NSMutableArray = NSMutableArray()
    var selectedDateIndex : Int = 2
    var selectedExpressDeliveryButton : Int = 0  //0 means none of them is selected 1 means first is selected 2 means second is selected
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dateSelectionCollectionView.register(DateCollectionViewCell.nib, forCellWithReuseIdentifier: DateCollectionViewCell.identifier)
        
        timeSelectionCollectionView.register(TimeCollectionViewCell.nib, forCellWithReuseIdentifier: TimeCollectionViewCell.identifier)

        
        
        pickUpDateViewModel.getPickUpDate { [weak self] (isSuccess, message) in
            guard let strongSelf = self else{return}
            
            if isSuccess {
                DispatchQueue.main.async {
                    
                    strongSelf.dateSelectionCollectionView.reloadData()
                    
                    guard let dateStr =  strongSelf.pickUpDateViewModel.pickUpFirstDate() else {return }
                    strongSelf.selectedDate = dateStr
                    
                    
                    guard let time =  strongSelf.pickUpDateViewModel.pickUpFirstTime() else {return }
                    strongSelf.selectedTime = time
                    
                    
                    strongSelf.timeSelectionCollectionView.reloadData()
                    
                    
                }
                
            }else{
                showAlertMessage(vc: strongSelf, title: .Error, message: message)
            }
            
            
            
        }
    }

    
    
    @IBAction func schedulePickupButtonClick(sender: AnyObject) {
        
        if self.selectedExpressDeliveryButton == 0 && self.showDropOff == true {
            //none of them is selected and user can select drop then send to drop off controller
            //self.performSegueWithIdentifier(SEGUE_DROPOFF_IDENTIFIER, sender: self)
            
        }else {
            //user has selected fast delivery or he can not choose drop off
            if self.pickupNumber.isEmpty {
                //Fresh Pick Up hence flag = 1
                self.hitRequestPickupWebService(flag: 1)
            }else{
                //Reschedule hence flag = 2
                self.hitRequestPickupWebService(flag: 2)
            }
        }
        
    }

    
    func hitRequestPickupWebService(flag:Int) {
        //flag 1 for request new pick up and 2 for reschedule
        var expressId:String
        
        switch self.selectedExpressDeliveryButton {
        case 0:
            expressId = ""
        case 1:
            expressId = "\(self.firstButton.tag)"
        case 2:
            expressId = "\(self.secondButton.tag)"
        default:
            expressId = ""
        }
        
        var instruction = ""
        
        
        
        if self.specialInstructionTextView.text == "Special Instruction"{
            instruction = ""
        }else if let inst = self.specialInstructionTextView.text{
            instruction = inst
        }
        
     
        //let dict:NSDictionary? = NSDictionary.init(object: tempDict!, forKey: kWebServicePostParamKey)
        schedulePickUpDateClient.getSchedulePickup(pickupDate: self.selectedDate, pickupTime: self.selectedTime, flag: flag, pickupNumber: "", expressDeliveryID: expressId, specialInstruction: instruction, dropOffDate: "", dropOffTime: "", cancelReason: "") { (shedulePickUpModel, message) in
            
            if let shedulePickUpModel = shedulePickUpModel {
                
                guard let navViewController = SuccessfullPickUpVC.getStoryboardInstance(),
                    let viewController = navViewController.topViewController as? SuccessfullPickUpVC
                    else { return  }
                self.navigationController?.pushViewController(viewController, animated: true)
            }else{
                
                showAlertMessage(vc: self, title: .Error, message: message)
            }
            
            
            
        }
        
        /*QDCPickUpWebService.hitApi(dict!, responseValue: { (isSuccess, response,header, error) ->
            Void in
            if isSuccess{
                
                let status = header!["Status"] as! String
                
                
                if status == "False" {
                    //order failed due to some reason
                    let reason = header!["Reason"] as! String
                    let alert:UIAlertView  = UIAlertView.init(title: "", message: reason, delegate: self, cancelButtonTitle: "Ok")
                    alert.show()
                }else{
                    //sucessfull order with order id as status
                    self.pickupNumber = status
                    
                    //send to drop off screen if drop is mendat and user has not selected express delivery
                    
                    
                    if self.selectedExpressDeliveryButton != 0 {
                        //this means either of the express delivery is selected send to congratulation screen with pick up and drop off message
                        self.performSegueWithIdentifier(SEGUE_CONGRATULATIONS_SCHEDULE_IDENTIFIER, sender: self)
                    } else {
                        //send to congratulations screen with pick up only message
                        self.performSegueWithIdentifier(SEGUE_CONGRATULATIONS_SCHEDULE_IDENTIFIER, sender: self)
                    }
                }
                
                
            }else{
                
            }
        })*/
    }
    
    
}



extension PickUpDateVC{
    static func getStoryboardInstance() -> UINavigationController?{
        let storyborad = UIStoryboard(name: String(describing: self), bundle: nil)
        guard let navViewController = storyborad.instantiateInitialViewController()  as? UINavigationController else { return nil }
        return navViewController
    }
}




extension PickUpDateVC:UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 1 {
            
            if indexPath.row == 0 || indexPath.row == 1 {
                return // previos dates
            }
            
            // let scheduleModel = self.pickUpScheduleArray.objectAtIndex(indexPath.item) as? QDCScheduleModel
            guard let selDate = pickUpDateViewModel.pickUpDate(for: indexPath) else{ return }
            
             self.selectedDate = selDate
             //self.selectedTime = (scheduleModel?.timeArray.objectAtIndex(0))! as! String
             self.selectedDateIndex = indexPath.item
             self.dateSelectionCollectionView.reloadData()
             self.timeSelectionCollectionView.reloadData()
 
        }else{
            
             //let scheduleModel = self.pickUpScheduleArray.objectAtIndex(selectedDateIndex) as? QDCScheduleModel
            guard let timeStr = pickUpDateViewModel.pickUpTime(for: indexPath, pickUpDate: self.selectedDate) else{return}
             self.selectedTime = timeStr //(scheduleModel?.timeArray.objectAtIndex(indexPath.item))! as! String
             self.timeSelectionCollectionView.reloadData()
        }
    }
    
    
}

extension PickUpDateVC:UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var cellSize:CGSize!
        
        if collectionView.tag == 1 {
            cellSize = CGSize(width: 66, height: 85)
        }else{
            let width = (SCREEN_SIZE.width/3)
            cellSize = CGSize(width: width, height: width/2)
            
        }
        
        return cellSize
    }
    
}

extension PickUpDateVC:UICollectionViewDataSource{
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 1 {
            return pickUpDateViewModel.numberOfPickUpDate()
        }else{
        
            return pickUpDateViewModel.numberOfPickUpTime(pickUpDate:selectedDate)
        }
        
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if collectionView.tag == 1 {
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DateCollectionViewCell.identifier, for: indexPath) as? DateCollectionViewCell else { return UICollectionViewCell() }
            //cell.dateLabel.text = pickUpDateViewModel.pickUpDate(for: indexPath)
        guard let dateStr =  pickUpDateViewModel.pickUpDate(for: indexPath) else {return UICollectionViewCell()  }
        if indexPath.row == 0 || indexPath.row == 1 {
            
            
            
            cell.contentView.backgroundColor = .lightGray
            cell.dayLabel.textColor = .gray
            cell.dateLabel.textColor = .gray
            cell.monthLabel.textColor = .gray
        }else{
            //let scheduleModel = self.pickUpScheduleArray.objectAtIndex(indexPath.item) as? QDCScheduleModel
            //dateString = (scheduleModel?.date)!
            cell.contentView.backgroundColor = UIColor.white
            //cell.dateLabel.textColor = BUTTON_COLOUR
            cell.dayLabel.textColor = UIColor.darkGray
            cell.monthLabel.textColor = UIColor.darkGray
        }
        
        let tempArr = dateStr.components(separatedBy: " ")//componentsSeparatedByString(" ")
        cell.dayLabel.text = CommonUtilities.getWeekDayFromString(dateString: dateStr)
        cell.dateLabel.text = tempArr[0]
        cell.monthLabel.text = tempArr[1] 
        
        if dateStr == self.selectedDate {
            cell.arrowImageView.isHidden = false
        }else{
            cell.arrowImageView.isHidden = true
        }
            return cell
        }else{

            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TimeCollectionViewCell.identifier, for: indexPath) as? TimeCollectionViewCell else { return UICollectionViewCell() }

            
            //let scheduleModel = self.pickUpScheduleArray.objectAtIndex(self.selectedDateIndex) as? QDCScheduleModel
            
            guard let timeString = pickUpDateViewModel.pickUpTime(for: indexPath, pickUpDate: selectedDate) else{return UICollectionViewCell()}//(scheduleModel?.timeArray[indexPath.item])! as! String
            
            cell.timeLabel.text = timeString
//            if timeString.containsString("AM") {
//                cell.timeLabel.text = timeString.stringByReplacingOccurrencesOfString("AM", withString: "")
//                cell.formatLabel.text = "AM"
//            }else{
//                cell.timeLabel.text = timeString.stringByReplacingOccurrencesOfString("PM", withString: "")
//                cell.formatLabel.text = "PM"
//            }
//
//            if timeString == self.selectedTime {
//                cell.contentView.backgroundColor = BUTTON_COLOUR
//                cell.timeLabel.textColor = UIColor.whiteColor()
//            }else{
//                cell.contentView.backgroundColor = UIColor.whiteColor()
//                cell.timeLabel.textColor = BUTTON_COLOUR
//            }
           return cell
        }
    }
    
    
}
