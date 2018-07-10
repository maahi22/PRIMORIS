//
//  PriceListClient.swift
//  QDCCustomerApp
//
//  Created by Maahi on 10/07/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import UIKit
import Alamofire



class PriceListClient: NSObject {

    // MARK: - Injections
    internal let networkClient = NetworkClient.shared
    
    func featchPriceList(completion:@escaping ([PriceListModel]?,String)->())  {
        
        let branchName = QDCUserDefaults.getDataBaseName()
        let branchId = QDCUserDefaults.getBranchId()
        
        let apiname = PRICE_LIST_RELATIVE_URL + branchName + "/" + branchId
        networkClient.callAPIWithAlamofire(apiname: apiname,
                                           requestType: .get,
                                           params: nil,
                                           headers: nil,
                                           success: { (data, httpResponse) in
                                            if let priceListModel = decodeJSON(type: [PriceListModel].self, from: data) {
                                                completion(priceListModel, "Success")
                                            }else{
                                                completion(nil,"failed")
                                            }
                                            
        }) { (error, message) in
            
            completion(nil,message)
            
        }
    }
    
    
    
}
