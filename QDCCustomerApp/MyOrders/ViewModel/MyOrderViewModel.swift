//
//  MyOrderViewModel.swift
//  QDCCustomerApp
//
//  Created by Maahi on 11/07/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import UIKit

class MyOrderViewModel: NSObject {

    @IBOutlet private var myOrderClient:MyOrderClient!
    var orderSummaryModel:OrderSummaryModel?
    
    
    
    
    
    func getMyOrder(completion:@escaping(Bool,String)->())  {
        
        myOrderClient.featchMyOrder { [weak self] (orderSummaryModel, message) in
            guard let strongSelf = self else{return}
            if let orderSummaryModel = orderSummaryModel{
                strongSelf.orderSummaryModel = orderSummaryModel
                completion(true,message)
            }else{
                completion(false,message)
            }
        }
        
    }
    
    func numberOfmyOrder() -> Int {
        guard let orderSummaryModel = orderSummaryModel else { return 0 }
        guard let orderModel = orderSummaryModel.myOrderModel else { return 0 }
        return orderModel.count
    }
    
    func myOrderForIndexPath(_ indexPath:IndexPath) -> MyOrderModel? {
        guard let orderSummaryModel = orderSummaryModel else { return nil }
        guard let myOrderModel = orderSummaryModel.myOrderModel else { return nil }
        return myOrderModel[indexPath.row]
    }
    
    
}
