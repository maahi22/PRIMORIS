//
//  OrderDetailCell.swift
//  QDCCustomerApp
//
//  Created by Maahi on 09/07/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import UIKit

class OrderDetailCell: UITableViewCell {

    
    @IBOutlet weak var garmentNameLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    
    static var identifier:String{
        return String(describing: self)
    }
    static var nib:UINib{
        return UINib(nibName: identifier, bundle: nil)
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var myOrderDetailModel:OrderSubDetailModel?{
        didSet{
            guard let orderDetailObj = myOrderDetailModel else { return  }
            
            
            garmentNameLabel.text = orderDetailObj.garmentName
            categoryLabel.text = orderDetailObj.services
            statusLabel.text = orderDetailObj.status
            guard  let iconUrl =  orderDetailObj.iconUrl else {
                return
            }
           // iconImageView.text = orderDetailObj.totalAmount
            
            
        }
    }
    
    
    func setupUI(orderSubDetailObj:OrderSubDetailModel) {
        
        self.garmentNameLabel.text = orderSubDetailObj.garmentName
        self.categoryLabel.text = orderSubDetailObj.services
        self.statusLabel.text = orderSubDetailObj.status
        
        guard  let iconUrl =  orderSubDetailObj.iconUrl else {
            return
        }
        
        let downloadURL = NSURL(string:iconUrl )!
//        Alamofire.request(.GET, downloadURL).response { (request, response, data, error) in
//            self.iconImageView.image = UIImage(data: data!, scale:1)
//        }
    }
    
    
    
    
}
