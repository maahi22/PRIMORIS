//
//  DueAmountVC.swift
//  QDCCustomerApp
//
//  Created by Amit Pant on 04/07/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import UIKit
import Razorpay

class DueAmountVC: UIViewController, RazorpayPaymentCompletionProtocol {

    @IBOutlet private var dueAmountClient:DueAmountClient!
    //private var customerSummaryModel:CustomerSummaryModel
    
    @IBOutlet weak var dueAmountLabel:UILabel!
    @IBOutlet weak var amountTitleLabel:UILabel!
    @IBOutlet weak var payNowButton:UIButton!
    
    var razorpayTestKey = "rzp_test_UWsFTZ8whOaHyK"
    var razorpay: Razorpay!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        payNowButton.setButtonTheme()
        razorpay = Razorpay.initWithKey(razorpayTestKey, andDelegate: self)
        dueAmountClient.getDueAmount { [weak self] (customerSummaryModel, message) in
            guard let strongSelf = self else{return}
            
            if let customerSummaryModel = customerSummaryModel {
                DispatchQueue.main.async {
                    
                    //if let amount = customerSummaryModel.PendingAmount {
                        strongSelf.amountTitleLabel.text = customerSummaryModel.PendingAmount
                   // }
                    
                    
                }
                
            }else{
                showAlertMessage(vc: strongSelf, title: .Error, message: message)
            }
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupUI() {
        
        self.dueAmountLabel.textColor = GRAY_COLOUR_ON_BUTTON
        self.amountTitleLabel.textColor = BUTTON_COLOUR
        //self.amountDetailTitleLabel.textColor = GRAY_COLOUR_ON_BUTTON
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    internal func showPaymentForm(amount:String){
        let options: [String:Any] = [
            "amount" : "\(amount)", //mandatory in paise
            "description": "",
            "image": "",
            "name": "QDC - On Demand",
            "prefill": [
            "contact": "",
            "email": ""
            ],
            "theme": [
                "color": "#F37254"
            ]
        ]
        razorpay.open(options)
    }

    public func onPaymentError(_ code: Int32, description str: String){
        let alertController = UIAlertController(title: "FAILURE", message: str, preferredStyle: UIAlertControllerStyle.alert)
        let cancelAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
        alertController.addAction(cancelAction)
        self.view.window?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
    
    public func onPaymentSuccess(_ payment_id: String){
        let alertController = UIAlertController(title: "SUCCESS", message: "Payment Id \(payment_id)", preferredStyle: UIAlertControllerStyle.alert)
        let cancelAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
        alertController.addAction(cancelAction)
        self.view.window?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func payNowPressed(_ sender: UIButton) {
        guard let dueAmount = amountTitleLabel.text else { return  }
        let arrAmt = dueAmount.components(separatedBy: " ")
        
        if arrAmt.count == 2 {
            let payAmt = (Int(arrAmt[0]) ?? 0) * 100
            showPaymentForm(amount: "\(payAmt)")
        }
        
        
    }
}

extension DueAmountVC{
    static func getStoryboardInstance() -> UINavigationController?{
        let storyborad = UIStoryboard(name: String(describing: self), bundle: nil)
        guard let navViewController = storyborad.instantiateInitialViewController()  as? UINavigationController else { return nil }
        return navViewController
    }
}
