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
    var dropOffModel: MyRequestDropOffModel?
    
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
            dropOffModel = serveMyDropoff
            
            
            
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
    
    
    
    
    
    
    //History cell
    
    func showRescheduleDetail(dropOffObj : MyRequestDropOffModel) {
        
        historyTableView.delegate = self
        historyTableView.dataSource = self
        
            self.registerCell()
            self.historyTableView.reloadData()
    
    }
    
    @IBAction func rescheduleButtonClick(sender: AnyObject) {
        
        requestCelldelegate?.didSelectRescheduleButton(self.Obj)
        print("reschedule")
    }
    
    @IBAction func cancelButtonClick(sender: AnyObject) {
        requestCelldelegate?.didSelectCancelButton(self.Obj)
        print("cancel")
    }
    
    
    
    
    
    func registerCell() {
        historyTableView.register(PickupHistoryCell.nib, forCellReuseIdentifier: PickupHistoryCell.identifier)
    }
    
    
    
    
    
    
}


extension MyRequestCell: UITableViewDelegate,UITableViewDataSource {
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        
        guard let offerCell = historyTableView.dequeueReusableCell(withIdentifier: PickupHistoryCell.identifier, for: indexPath as IndexPath)  as? PickupHistoryCell else { return UITableViewCell() }
        
        
        
        if (dropOffModel?.History?.count)! > 0 {
            
            if let list =  dropOffModel?.History{
                
                let dropOffHistory = list[indexPath.row]
                offerCell.setupUI(dropOffHistory: dropOffHistory)
                self.separatorView.isHidden = true
                
            }else{
                self.separatorView.isHidden = false
            }
            
            
            
            
        }else{
            self.separatorView.isHidden = false
        }
        return offerCell
    }
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        if let list =  dropOffModel?.History{
            return list.count
        }else{
            return 0
        }
     }
    

    
     
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            return 22
        }
        return 63
        
    }
    
    
    
    
    
    
}
