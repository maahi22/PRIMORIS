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
    var orderModel:[OrderModel]?
    
    
    
    
    
    func getMyOrder(completion:@escaping(Bool,String)->())  {
        
        myOrderClient.featchMyOrder { [weak self] (orderModel, message) in
            guard let strongSelf = self else{return}
            if let orderModel = orderModel{
                strongSelf.orderModel = orderModel
                completion(true,message)
            }else{
                completion(false,message)
            }
        }
        
    }
    
    func numberOfmyOrder() -> Int {
        guard let orderModel = orderModel else { return 0 }
        //guard let orderModel = orderModel.orderDetailsModel else { return 0 }
        guard let myOrderdetailModel = orderModel[0].orderDetailsModel else { return 0 }
        return myOrderdetailModel.count
    }
    
    func myOrderForIndexPath(_ indexPath:IndexPath) -> OrderDetailsModel? {
        guard let orderModel = orderModel else { return nil }
        guard let myOrderdetailModel = orderModel[0].orderDetailsModel else { return nil }
        return myOrderdetailModel[indexPath.row]
    }
    
    
}
