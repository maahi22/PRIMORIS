//
//  DropOffVC.swift
//  QDCCustomerApp
//
//  Created by Maahi on 07/07/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import UIKit

class DropOffVC: UIViewController {

    @IBOutlet weak var timeSelectionCollectionView:UICollectionView!
    @IBOutlet weak var dateSelectionCollectionView:UICollectionView!
    @IBOutlet weak var scheduleDropOffButton:UIButton!
    @IBOutlet weak var skipDropOffButton:UIButton!
    @IBOutlet weak var scheduleButtonWidthConstraint:NSLayoutConstraint!
    @IBOutlet weak var skipButtonWidthConstraint:NSLayoutConstraint!
    
    var pickupNumber:String = ""
    var dropoffNumber:String = ""
    var bookingId:String = ""
    var requireDropOff:Bool = true
    var selectedPickupDate:String = ""
    var selectedPickupTime:String = ""
    var selectedDropOffDate:String = ""
    var selectedDropOffTime:String = ""
    var pickUpInstruction:String = ""
    var isComingFromPickUp = false // this means hit schedule pick up api and not drop off api
    var dropOffUpScheduleArray:NSMutableArray = NSMutableArray()
    var selectedDateIndex : Int = 2
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}




extension DropOffVC{
    static func getStoryboardInstance() -> UINavigationController?{
        let storyborad = UIStoryboard(name: String(describing: self), bundle: nil)
        guard let navViewController = storyborad.instantiateInitialViewController()  as? UINavigationController else { return nil }
        return navViewController
    }
}
