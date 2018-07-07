//
//  SuccessfullPickUpVC.swift
//  QDCCustomerApp
//
//  Created by Maahi on 07/07/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import UIKit

class SuccessfullPickUpVC: UIViewController {

    
    @IBOutlet weak var messageLabel:UILabel!
    @IBOutlet weak var rescheduleButton:UIButton!
    @IBOutlet weak var cancelButton:UIButton!
    @IBOutlet weak var dashboardButton:UIButton!
    
    var message:String!
    var pickUpOrderId = ""
    var selectedPickupDate:String = ""
    var selectedPickupTime:String = ""
    
    var dropOffOrderId = ""
    var selectedDropOffDate:String = ""
    var selectedDropOffTime:String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    

}


extension SuccessfullPickUpVC{
    static func getStoryboardInstance() -> UINavigationController?{
        let storyborad = UIStoryboard(name: String(describing: self), bundle: nil)
        guard let navViewController = storyborad.instantiateInitialViewController()  as? UINavigationController else { return nil }
        return navViewController
    }
}
