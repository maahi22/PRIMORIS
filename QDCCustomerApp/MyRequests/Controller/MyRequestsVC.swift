//
//  MyRequestsVC.swift
//  QDCCustomerApp
//
//  Created by Maahi on 07/07/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import UIKit

class MyRequestsVC: UIViewController ,CancelReasonDelegate,MyRequestCellDelegate{
    
    @IBOutlet var myRequestViewModel:MyRequestViewModel!
    @IBOutlet var myDropOffViewModel:MyDropOffViewModel!
    
    @IBOutlet private var schedulePickUpDateClient:SchedulePickUpDateClient!
    @IBOutlet private var sheduledDropOffClient:SheduledDropOffClient!
    
   
    

    @IBOutlet weak var tableContainerView:UIView!
    @IBOutlet weak var mainScrollView:UIScrollView!
    @IBOutlet weak var myPickUpsTableView:UITableView!
    @IBOutlet weak var myDropOffsTableView:UITableView!
    @IBOutlet weak var myPickUpsButton:UIButton!
    @IBOutlet weak var myDropOffsButton:UIButton!
    @IBOutlet weak var viewUnderPickup:UIView!
    @IBOutlet weak var viewUnderDropoff:UIView!
    
    @IBOutlet weak var tableContainerViewWidthConstraint:NSLayoutConstraint!
    @IBOutlet weak var pickUpTableWidthConstraint:NSLayoutConstraint!
    @IBOutlet weak var dropOffTableWidthConstraint:NSLayoutConstraint!
    
    
    var isPickUpSelected:Bool = true
    var pickUpModelArr:NSArray = NSArray()
    var dropOffModelArr:NSArray = NSArray()
    var modelObj:AnyObject!
    var clickedRow:Int!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        myPickUpsTableView.register(MyRequestCell.nib, forCellReuseIdentifier: MyRequestCell.identifier)
        myDropOffsTableView.register(MyRequestCell.nib, forCellReuseIdentifier: MyRequestCell.identifier)
    
        myPickUpsTableView.tag = 1;
        myDropOffsTableView.tag = 2;
        
        self.myPickUpsButton.isSelected = true
        self.myDropOffsButton.isSelected = false
        
        myPickUpsTableView.isHidden = false
        myDropOffsTableView.isHidden = true
        
        self.viewUnderPickup.backgroundColor = PRIMARY_COLOUR
        self.viewUnderDropoff.backgroundColor = UIColor.white
        
        
        

        self.hitMyRequestWebService()
    }

    
    
   
    
    
    @IBAction func myPickUpsButtonClick(_ sender: Any) {
        
        self.isPickUpSelected = true
        self.myPickUpsButton.isSelected = true
        self.myDropOffsButton.isSelected = false
        self.mainScrollView.contentOffset = CGPoint(x: 0, y: 0)
        self.viewUnderPickup.backgroundColor = PRIMARY_COLOUR
        self.viewUnderDropoff.backgroundColor = UIColor.white
        
        
        myPickUpsTableView.isHidden = false
        myDropOffsTableView.isHidden = true
        
        self.hitMyRequestWebService()
    }
    
    
    @IBAction func myDropOffsButtonClick(_ sender: Any) {
        
        
        
        self.isPickUpSelected = false
        self.myPickUpsButton.isSelected = false
        self.myDropOffsButton.isSelected = true
        self.mainScrollView.contentOffset = CGPoint(x:SCREEN_SIZE.width,y:0)
        self.viewUnderDropoff.backgroundColor = PRIMARY_COLOUR
        self.viewUnderPickup.backgroundColor = UIColor.white
        
        myPickUpsTableView.isHidden = true
        myDropOffsTableView.isHidden = false
        
        self.hitMyDropOffRequestWebService()
        
        
    }
    
    
    
    func hitMyRequestWebService(){
        
        myRequestViewModel.getMyRequest { [weak self] (isSuccess, message)  in
            
            guard let strongSelf = self else{return}
            
            if isSuccess {
                DispatchQueue.main.async {
                    strongSelf.myPickUpsTableView.reloadData()
                }
                
            }else{
                showAlertMessage(vc: strongSelf, title: .Error, message: message)
            }
            
            
        }
    }
    
    func hitMyDropOffRequestWebService(){
        //Load data
        
        myDropOffViewModel.getDropOff { [weak self] (isSuccess, message)  in
            guard let strongSelf = self else{return}
            
            if isSuccess {
                DispatchQueue.main.async {
                    strongSelf.myDropOffsTableView.reloadData()
                }
            }else{
                showAlertMessage(vc: strongSelf, title: .Error, message: message)
            }
        }
    }

    
    
    
    
    
    
   //Delegate methods
    func didSelectRescheduleButton(_ obj: AnyObject) {
        
          if self.isPickUpSelected  {
            
            let pickUpObj:MyRequestModel = obj as! MyRequestModel
            
            guard let navViewController = PickUpDateVC.getStoryboardInstance(),
                let viewController = navViewController.topViewController as? PickUpDateVC
                else { return  }
            if let picNo = pickUpObj.PickUpNumber{
              viewController.pickupNumber = picNo
            }
            
            self.navigationController?.pushViewController(viewController, animated: true)
            
            
        }else{
            
            
            let dropOffObj:MyRequestDropOffModel = obj as! MyRequestDropOffModel
            
            guard let navViewController = DropOffVC.getStoryboardInstance(),
                let viewController = navViewController.topViewController as? DropOffVC
                else { return  }
            if let picNo = dropOffObj.PickUpNumber{
                viewController.pickupNumber = picNo
            }
            
            self.navigationController?.pushViewController(viewController, animated: true)
            
            
        }
        
    }
    
    func didSelectCancelButton(_ obj: AnyObject) {
        
        self.modelObj = obj
        
        guard let navViewController = CancelReasonVC.getStoryboardInstance(),
            let viewController = navViewController.topViewController as? CancelReasonVC
            else { return  }
        viewController.cancelOrderdelegate = self
        self.present(navViewController, animated: true, completion: {})
        
    }
    
    func didSelectCancelReason(_ cancelReason: String) {
        if self.isPickUpSelected {
            self.hitCancelPickupWebService(cancelReason)
        }else{
            
            self.hitCancelDropOffWebService(cancelReason)
        }
        
        
    }
    
    
    
    
    func hitCancelDropOffWebService(_ cancelReason:String) {
        
        let dropOffObj:MyRequestDropOffModel = modelObj as! MyRequestDropOffModel
        
        sheduledDropOffClient.getScheduleDropOff(dropOffDate: dropOffObj.PickUpDate!, dropOffTime: dropOffObj.DropOffTime!, flag: 3, pickupNumber: "", bookingNo: "", dropOffNumber: dropOffObj.DropOffNumber!, cancelReason: cancelReason) {[weak self] (scheduleDropOffModel, message) in
            
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
    
     func hitCancelPickupWebService(_ cancelReason:String) {
        
        let pickUpObj:MyRequestModel = modelObj as! MyRequestModel
        
        
        schedulePickUpDateClient.getSchedulePickup(pickupDate: pickUpObj.PickUpDate!, pickupTime: pickUpObj.PickUpTime!, flag: 3, pickupNumber: pickUpObj.PickUpNumber!, expressDeliveryID: "", specialInstruction: "", dropOffDate: "", dropOffTime: "", cancelReason: cancelReason) { [weak self](schedulePickUpModel, message) in
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
    
}

extension MyRequestsVC{
    static func getStoryboardInstance() -> UINavigationController?{
        let storyborad = UIStoryboard(name: String(describing: self), bundle: nil)
        guard let navViewController = storyborad.instantiateInitialViewController()  as? UINavigationController else { return nil }
        return navViewController
    }
}






extension MyRequestsVC:UITableViewDataSource{
    
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 0.1))
        footerView.backgroundColor = UIColor.clear
        return footerView
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 1 {
            return myRequestViewModel.numberMyRequest()
        }else{
            return myDropOffViewModel.numberMyRequestDropOff()
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if tableView.tag == 1 {
            
             guard let cell = tableView.dequeueReusableCell(withIdentifier: MyRequestCell.identifier, for: indexPath)  as? MyRequestCell else { return UITableViewCell() }
            
            cell.selectionStyle = .none
            cell.requestCelldelegate = self
            cell.setupUI()
            cell.serveMyRequest = myRequestViewModel.myRequestAt(for: indexPath)
            cell.arrowLabel.isHidden = true
            cell.historyTableView.isHidden = true
            
            
            return cell
            
        }else {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MyRequestCell.identifier, for: indexPath)  as? MyRequestCell else { return UITableViewCell() }
            
            cell.selectionStyle = .none
            cell.requestCelldelegate = self
            cell.setupUI()
            cell.serveMyDropoff = myDropOffViewModel.myRequestDropOffAt(for: indexPath)
            
            //
 //           cell.arrowLabel.isHidden = true
            
//            if self.dropOffModelArr.count > 0 {
//
//                /*let dropoffModel:QDCCustomerDropoffModel = self.dropOffModelArr[indexPath.row] as! QDCCustomerDropoffModel
//                cell.dateLabel.text = dropoffModel.dropOffDate
//                cell.timeLabel.text = dropoffModel.dropOffTime
//                cell.Obj = dropoffModel
//
//                if dropoffModel.history.count > 1 {
//                    cell.arrowLabel.isHidden = false
//                    cell.historyTableView.isHidden = true
//                }else{
//                    cell.arrowLabel.isHidden = true
//                    cell.historyTableView.isHidden = true
//                }
//
//                if ((clickedRow != nil) && (clickedRow == indexPath.row)) {
//                    cell.arrowLabel.isHidden = true
//                    cell.historyTableView.isHidden = false
//                    cell.showRescheduleDetail(dropoffModel)
//                }*/
//            }
            
            
            return cell
            
        }
        
   
    }
}

extension MyRequestsVC:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        if tableView.tag == 1 { //pickup table
            return 85
        }
        
//        if self.dropOffModelArr.count > indexPath.row {
//           /* let dropoffModel:QDCCustomerDropoffModel = self.dropOffModelArr[indexPath.row] as! QDCCustomerDropoffModel
//            if ((clickedRow != nil) && (clickedRow == indexPath.row)){
//                return CGFloat(80 + (dropoffModel.history.count - 1)*63 + 22)
//            } else {
//                return 80
//            }*/
//
//            return 80
//        }else{
//            return 80
//        }
        
        return 80
    }
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if tableView.tag == 2 {
            if ((clickedRow != nil) && (clickedRow == indexPath.row)){
                clickedRow = nil
            }else {
                clickedRow = indexPath.row
            }
            self.myDropOffsTableView.reloadData()
        }
        
    }
}


