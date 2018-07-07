//
//  OrderDetailVC.swift
//  QDCCustomerApp
//
//  Created by Maahi on 07/07/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import UIKit

class OrderDetailVC: UIViewController {

    
    
    @IBOutlet weak var orderDetailTableView: UITableView!
    
    @IBOutlet weak var orderLabel:UILabel!
    @IBOutlet weak var dueDateLabel:UILabel!
    @IBOutlet weak var totalPriceLabel:UILabel!
    @IBOutlet weak var totalClothsLabel:UILabel!
    @IBOutlet weak var pendingPriceLabel:UILabel!
    @IBOutlet weak var pendingClothsLabel:UILabel!
    
    @IBOutlet weak var orderImageView:UIImageView!
    @IBOutlet weak var dateImageView:UIImageView!
    @IBOutlet weak var totalPriceImageView:UIImageView!
    @IBOutlet weak var totalClothImageView:UIImageView!
    @IBOutlet weak var pendingPriceImageView:UIImageView!
    @IBOutlet weak var pendingClothImageView:UIImageView!
    
    
    @IBOutlet weak var scheduleButton:UIButton!
    
   // var orderDetailModelObj:QDCOrderDetailModel!
    var orderDetailArray:NSArray = NSArray()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    

}


extension OrderDetailVC{
    static func getStoryboardInstance() -> UINavigationController?{
        let storyborad = UIStoryboard(name: String(describing: self), bundle: nil)
        guard let navViewController = storyborad.instantiateInitialViewController()  as? UINavigationController else { return nil }
        return navViewController
    }
}
