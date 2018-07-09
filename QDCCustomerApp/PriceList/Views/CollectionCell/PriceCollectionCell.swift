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
    
    
    
//    func registerNib() {
//        
//        //let priceCellName = UINib(nibName: "QDCPriceTableViewCell", bundle:nil)
//        //priceTableView!.registerNib(priceCellName, forCellReuseIdentifier: PRICE_CELL_IDENTIFIER)
//        self.priceTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: PRICE_CELL_IDENTIFIER)
//    }
//    
//    func registerCell() {
//        
//        self.priceTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: PRICE_CELL_IDENTIFIER)
//        
//    }
//    
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        
//        return self.garmentArray.count
//        
//    }
//    
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        
//        //        let priceCell = priceTableView!.dequeueReusableCellWithIdentifier(PRICE_CELL_IDENTIFIER) as!  QDCPriceTableViewCell
//        //
//        //        priceCell.setupUI()
//        var priceCell = tableView.dequeueReusableCellWithIdentifier(PRICE_CELL_IDENTIFIER) as UITableViewCell!
//        if priceCell == nil {
//            priceCell = UITableViewCell(style:.Value1, reuseIdentifier: PRICE_CELL_IDENTIFIER)
//        }
//        
//        let garmentDict = self.garmentArray[indexPath.row] as! NSDictionary
//        
//        
//        if let val = garmentDict["Garment"] as? String{
//            let garmentNameCategoryArray = val.componentsSeparatedByString("-") // Household - Bed Sheet Single
//            priceCell.textLabel?.text = garmentNameCategoryArray[1]
//        }
//        
//        if let val = garmentDict[self.service] as? NSNumber{
//            priceCell.detailTextLabel?.text = String (val)
//        }
//        priceCell.selectionStyle = UITableViewCellSelectionStyle.None
//        return priceCell
//    }
//    
//    
//    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        
//        
//        return 51 ;
//        
//    }
}
