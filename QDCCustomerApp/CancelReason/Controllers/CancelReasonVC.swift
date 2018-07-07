//
//  CancelReasonVC.swift
//  QDCCustomerApp
//
//  Created by Maahi on 07/07/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import UIKit

protocol CancelReasonDelegate {
    
    func didSelectCancelReason(cancelReason:String) ;
    
}

class CancelReasonVC: UIViewController {

    
    @IBOutlet weak var reasonTextView: UITextView!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var containerVeiwBottomConstraint: NSLayoutConstraint!
    var selectedButton : UIButton!
    var cancelOrderdelegate:CancelReasonDelegate! = nil
    let reasonArray:NSArray = ["I changed my mind","Pickup date already passed","I was just checking it","Will do it later"]
    
    
    
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
