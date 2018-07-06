//
//  MenuItemTableViewCell.swift
//  I-Helper
//
//  Created by Kripa Tripathi on 17/11/17.
//  Copyright © 2017 Maxtra Technologies P LTD. All rights reserved.
//

import UIKit

class MenuItemTableViewCell: UITableViewCell {

  @IBOutlet weak var menuItemImageView: UIImageView!
  @IBOutlet weak var menuItemNameLabel: UILabel!
  
  var menuItem:Section?{
    didSet{
      guard let menuItem = menuItem else { return  }
      menuItemNameLabel.text = menuItem.name
      menuItemImageView.image = UIImage(named: menuItem.image)
      menuItemImageView.highlightedImage = UIImage(named: menuItem.selImage)
    }
  }
  static var nib:UINib {
    return UINib(nibName: identifier, bundle: nil)
  }
  
  static var identifier: String {
    return String(describing: self)
  }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
