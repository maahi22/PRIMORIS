//
//  OfferCell.swift
//  QDCCustomerApp
//
//  Created by Maahi on 09/07/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import UIKit

class OfferCell: UITableViewCell {

    
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
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
    
    
    
    /*func setupUI(offerDict:NSDictionary) {
        
        self.titleLabel.text = offerDict["Title"] as? String
        self.descriptionLabel.text = offerDict["Descreption"] as? String
        
        self.iconImageView.image = self.iconImageView.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        self.iconImageView.tintColor = APP_ICON_COLOUR
        
        self.titleLabel.textColor = PRIMARY_COLOUR
        self.descriptionLabel.textColor = UIColor.blackColor()
        
    }*/
    
}
