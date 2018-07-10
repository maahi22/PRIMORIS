//
//  MyRequestsVC.swift
//  QDCCustomerApp
//
//  Created by Maahi on 07/07/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import UIKit

class MyRequestsVC: UIViewController ,CancelReasonDelegate,MyRequestCellDelegate{
    
    @IBOutlet var myRequestViewModel:MyRequestViewModel!
    @IBOutlet var myDropOffViewModel:MyDropOffViewModel!
    
    
    func didSelectRescheduleButton(obj: AnyObject) {
        
    }
    
    func didSelectCancelButton(obj: AnyObject) {
        
    }
    
    func didSelectCancelReason(cancelReason: String) {
        
    }
    

    @IBOutlet weak var tableContainerView:UIView!
    @IBOutlet weak var mainScrollView:UIScrollView!
    @IBOutlet weak var myPickUpsTableView:UITableView!
    @IBOutlet weak var myDropOffsTableView:UITableView!
    @IBOutlet weak var myPickUpsButton:UIButton!
    @IBOutlet weak var myDropOffsButton:UIButton!
    @IBOutlet weak var viewUnderPickup:UIView!
    @IBOutlet weak var viewUnderDropoff:UIView!
    
    @IBOutlet weak var tableContainerViewWidthConstraint:NSLayoutConstraint!
    @IBOutlet weak var pickUpTableWidthConstraint:NSLayoutConstraint!
    @IBOutlet weak var dropOffTableWidthConstraint:NSLayoutConstraint!
    
    
    var isPickUpSelected:Bool = true
    var pickUpModelArr:NSArray = NSArray()
    var dropOffModelArr:NSArray = NSArray()
    var modelObj:AnyObject!
    var clickedRow:Int!
    
    
    
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

extension MyRequestsVC{
    static func getStoryboardInstance() -> UINavigationController?{
        let storyborad = UIStoryboard(name: String(describing: self), bundle: nil)
        guard let navViewController = storyborad.instantiateInitialViewController()  as? UINavigationController else { return nil }
        return navViewController
    }
}
