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
    @IBOutlet private var myOrderClient:MyOrderClient!
    
    @IBOutlet weak var dueAmountLabel:UILabel!
    @IBOutlet weak var amountTitleLabel:UILabel!
    @IBOutlet weak var payNowButton:UIButton!
    
    var razorpayTestKey = "rzp_test_UWsFTZ8whOaHyK"
    var razorpay: Razorpay!
    var paidAmount = ""
    var pendingAmount = 0
    var orderNos = ""
    var paymentDone:(()->())?
    override func viewDidLoad() {
        super.viewDidLoad()

        
        payNowButton.setButtonTheme()
        razorpay = Razorpay.initWithKey(razorpayTestKey, andDelegate: self)
        
        myOrderClient.featchMyOrder { [weak self] (orderModel, message) in
            guard let strongSelf = self else{return}
            if let orderModel = orderModel, let orderDetails = orderModel.first?.OrderDetails{
                
                
                 strongSelf.pendingAmount = orderDetails.reduce(0, { pendingAmount, order in
                    
                    pendingAmount + (Int(order.PendingAmount ?? "0") ?? 0)
                })
                
                orderDetails.forEach({ (orderDetail) in
                    if strongSelf.orderNos.count > 0{
                        strongSelf.orderNos += "," + (orderDetail.OrderNo ?? "")
                    }else{
                        strongSelf.orderNos = orderDetail.OrderNo ?? ""
                    }
                })
                
                DispatchQueue.main.async {
                    
                    //if let amount = customerSummaryModel.PendingAmount {
                    strongSelf.amountTitleLabel.text = "\(strongSelf.pendingAmount) INR"
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
        
        dueAmountClient.updatePayment(paymentResponseData: payment_id,
                                      amount: paidAmount, orderNumber: orderNos) {[weak self] (isStatus, message) in
                                        guard let strongSelf = self else{return}
                                        if isStatus{
                                            showAlertMessage(vc: strongSelf, title: "Message", message: "Payment received successfully", actionTitle: "Ok", handler: { (action) in
                                                if let paymentDone = strongSelf.paymentDone{
                                                    paymentDone()
                                                    strongSelf.navigationController?.popViewController(animated: true)
                                                }
                                            })
                                        }else{
                                            showAlertMessage(vc: strongSelf, title: .Information, message: "Payment not received, please try again.")
                                        }
        }
        
        
//        let alertController = UIAlertController(title: "SUCCESS", message: "Payment Id \(payment_id)", preferredStyle: UIAlertControllerStyle.alert)
//        let cancelAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
//        alertController.addAction(cancelAction)
//        self.view.window?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func payNowPressed(_ sender: UIButton) {
        
        if pendingAmount > 0 {
            let payAmt = pendingAmount * 100
            paidAmount = "\(payAmt)"
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
