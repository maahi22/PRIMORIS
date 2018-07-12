//
//  MyRequestCell.swift
//  QDCCustomerApp
//
//  Created by Maahi on 09/07/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import UIKit

protocol MyRequestCellDelegate {
    
    func didSelectRescheduleButton(_ obj:AnyObject) ;
    func didSelectCancelButton(_ obj:AnyObject) ;
    
}

class MyRequestCell: UITableViewCell {

    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var rescheduleButton:UIButton!
    @IBOutlet weak var cancelButton:UIButton!
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var arrowLabel: UILabel!
    @IBOutlet weak var historyTableView: UITableView!
    
    var Obj: AnyObject!
    
    var requestCelldelegate:MyRequestCellDelegate?
    
    
    
    
    static var identifier:String{
        return String(describing: self)
    }
    static var nib:UINib{
        return UINib(nibName: identifier, bundle: nil)
    }
    
    
    
    var serveMyRequest:MyRequestModel?{
        didSet{
            guard let serviceArea = serveMyRequest else { return  }
            dateLabel.text = serviceArea.PickUpDate ?? ""
            timeLabel.text = serviceArea.PickUpTime ?? ""
            
            Obj = serviceArea as AnyObject
        }
    }
    
    var serveMyDropoff:MyRequestDropOffModel?{
        didSet{
            guard let serviceArea = serveMyDropoff else { return  }
            dateLabel.text = serviceArea.PickUpDate ?? ""
            timeLabel.text = serviceArea.DropOffTime ?? ""
            Obj = serveMyDropoff as AnyObject
            
            
            self.backgroundView?.backgroundColor = .red
            
           /* if (serviceArea.History?.count)! > 0 {
                
               
                 
                /*if (serviceArea.history?.count)! > 1 {
                 cell.arrowLabel.isHidden = false
                 cell.historyTableView.isHidden = true
                 }else{
                 cell.arrowLabel.isHidden = true
                 cell.historyTableView.isHidden = true
                 }
                 
                 if ((clickedRow != nil) && (clickedRow == indexPath.row)) {
                 cell.arrowLabel.isHidden = true
                 cell.historyTableView.isHidden = false
                 cell.showRescheduleDetail(dropoffModel)
                 }*/
            }*/
            
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    
    
    func setupUI() {
        
        self.dateLabel.textColor = TEXT_FIELD_COLOUR
        self.timeLabel.textColor = TEXT_FIELD_COLOUR
        
        self.rescheduleButton.setTitleColor(COLOUR_ON_BUTTON, for: UIControlState.normal)
        self.rescheduleButton.backgroundColor = BUTTON_COLOUR
        
        self.cancelButton.setTitleColor(COLOUR_ON_BUTTON, for: UIControlState.normal)
        self.cancelButton.backgroundColor = BUTTON_COLOUR
    }
    
    
    
    @IBAction func rescheduleButtonClick(_ sender: Any) {
        requestCelldelegate?.didSelectRescheduleButton( self.Obj)
        print("reschedule")
    }
    
    
    
    @IBAction func cancelButtonClick(_ sender: Any) {
        
        requestCelldelegate?.didSelectCancelButton( self.Obj)
        print("cancel")
    }
    
    
    
   /* func showRescheduleDetail(dropOffObj:QDCCustomerDropoffModel) {
        
        historyArray = dropOffObj.history
        self.registerCell()
        self.historyTableView.reloadData()
        
    }
    
    @IBAction func rescheduleButtonClick(sender: AnyObject) {
        
        requestCelldelegate.didSelectRescheduleButton(self.Obj)
        print("reschedule")
    }
    
    @IBAction func cancelButtonClick(sender: AnyObject) {
        requestCelldelegate.didSelectCancelButton(self.Obj)
        print("cancel")
    }
    
    func registerCell() {
        let cellName = UINib(nibName: "QDCPickupHistoryTableViewCell", bundle:nil)
        historyTableView.registerNib(cellName, forCellReuseIdentifier: historyCellIdentier)
    }
     
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
     return self.historyArray.count
     
     }
     
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
     
     let offerCell = historyTableView.dequeueReusableCellWithIdentifier(historyCellIdentier) as!  QDCPickupHistoryTableViewCell
     
     if self.historyArray.count > 0 {
     
     let dropOffHistory:QDCDropoffHistoryModel = self.historyArray[indexPath.row] as! QDCDropoffHistoryModel
     offerCell.setupUI(dropOffHistory)
     self.separatorView.hidden = true
     
     }else{
     self.separatorView.hidden = false
     }
     return offerCell
     }
     
     
     func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
     
     if indexPath.row == 0 {
     return 22
     }
     return 63
     
     }
    */
    
    
    
    
    
}
