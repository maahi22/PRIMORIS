//
//  PriceCollectionCell.swift
//  QDCCustomerApp
//
//  Created by Maahi on 09/07/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import UIKit

class PriceCollectionCell: UICollectionViewCell {

    
    @IBOutlet weak var priceTableView:UITableView!
    var garmentArray = NSArray()
    var service = ""
    
    
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

    
    func setupUI(garmentArr:NSArray, selectedService:String) {
        
        // self.registerNib()
        self.garmentArray = garmentArr
        self.service = selectedService
        self.priceTableView.reloadData()
    }
    
    
    
    

    
    func registerCell() {
        priceTableView.register(PriceCell.nib, forCellReuseIdentifier: PriceCell.identifier)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.garmentArray.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        guard let cell = priceTableView.dequeueReusableCell(withIdentifier: PriceCell.identifier, for: indexPath as IndexPath)  as? PriceCell else { return UITableViewCell() }
        
        
        
        let garmentDict = self.garmentArray[indexPath.row] as! NSDictionary
        
        
        if let val = garmentDict["Garment"] as? String{
            let garmentNameCategoryArray = val.components(separatedBy: "-") // Household - Bed Sheet Single
            cell.textLabel?.text = garmentNameCategoryArray[1]
        }
        
        if let val = garmentDict[self.service] as? NSNumber{
            cell.detailTextLabel?.text = "\(val)"
        }
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        return cell
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 51 ;
        
    }
}
