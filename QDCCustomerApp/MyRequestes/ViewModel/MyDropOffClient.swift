//
//  MyDropOffClient.swift
//  QDCCustomerApp
//
//  Created by Maahi on 10/07/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import UIKit

class MyDropOffClient: NSObject {

    // MARK: - Injections
    internal let networkClient = NetworkClient.shared
    
    
    //get offers
    func fetchMyDropOff(completion:@escaping ([DropOffModel]?,String)->())  {
        
        let custID = QDCUserDefaults.getCustomerId()
        let branchName = QDCUserDefaults.getDataBaseName()
        let branchID = QDCUserDefaults.getBranchId()
        let token = QDCUserDefaults.getAccessToken()
        
        
        let apiname = CUSTOMER_DROPOFFS_RELATIVE_URL + branchName + "/" + branchID + "/" + custID
        let headers = ["token": "\(token)"] as [String:String]
        
        networkClient.callAPIWithAlamofire(apiname: apiname,
                                           requestType: .get,
                                           params: nil,
                                           headers: headers,
                                           success: { (data, httpResponse) in
                                            
                                            if let dropOffModel = decodeJSON(type: [DropOffModel].self, from: data) {
                                                completion(dropOffModel, "Success")
                                            }else{
                                                completion(nil,"failed")
                                            }
                                            
        }) { (error, message) in
            
            completion(nil,message)
            
        }
        
        
    }
    
    
}
