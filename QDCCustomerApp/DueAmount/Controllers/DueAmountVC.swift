//
//  DueAmountVC.swift
//  QDCCustomerApp
//
//  Created by Amit Pant on 04/07/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import UIKit

class DueAmountVC: UIViewController {

    @IBOutlet private var dueAmountClient:DueAmountClient!
    //private var customerSummaryModel:CustomerSummaryModel
    
    @IBOutlet weak var dueAmountLabel:UILabel!
    @IBOutlet weak var amountTitleLabel:UILabel!
    @IBOutlet weak var amountDetailTitleLabel:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        
        dueAmountClient.getDueAmount { [weak self] (customerSummaryModel, message) in
            guard let strongSelf = self else{return}
            
            if let customerSummaryModel = customerSummaryModel {
                DispatchQueue.main.async {
                    
                    //if let amount = customerSummaryModel.PendingAmount {
                        strongSelf.self.amountTitleLabel.text = customerSummaryModel.PendingAmount
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
        self.amountDetailTitleLabel.textColor = GRAY_COLOUR_ON_BUTTON
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

extension DueAmountVC{
    static func getStoryboardInstance() -> UINavigationController?{
        let storyborad = UIStoryboard(name: String(describing: self), bundle: nil)
        guard let navViewController = storyborad.instantiateInitialViewController()  as? UINavigationController else { return nil }
        return navViewController
    }
}
