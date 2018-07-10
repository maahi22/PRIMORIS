//
//  DropOffClient.swift
//  QDCCustomerApp
//
//  Created by Maahi on 10/07/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import UIKit

class DropOffClient: NSObject {

    // MARK: - Injections
    internal let networkClient = NetworkClient.shared
    
    
    
    static var requestParamDict:NSDictionary?
    //pick up date
    func fetchDropOff(_ pickupDateKey:String ,_ pickupTimeKey:String,    completion:@escaping ([PickUpDateModel]?,String)->())  {
        
        let clientID = QDCUserDefaults.getClientID()
        let branchID = QDCUserDefaults.getBranchId()
        let token = QDCUserDefaults.getAccessToken()
        
        let dbName = QDCUserDefaults.getDataBaseName()
        //let apiname = PICKUP_DATE_RELATIVE_URL + "\(clientID)/\(branchID)"
        
       // var params = [PICKUP_DATE_REQUEST_KEY: pickupDateKey,PICKUP_TIME_REQUEST_KEY:pickupTimeKey] as [String:Any]
        
        
     var encodedPickupDate = ""
        if let str = pickupDateKey.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed){
            encodedPickupDate = str
        }
        
        var encodedPickupTime = ""
        if let str2 = pickupTimeKey.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed){
            encodedPickupTime = str2
        }
        
        
        let apiname  = DROPOFF_DATE_AND_TIME_RELATIVE_URL + "DatabaseName=\(dbName)&BranchID=\(branchID)&PickUpDate=\(encodedPickupDate)&PickUpTime=\(encodedPickupTime)"
            
            
            //DROPOFF_DATE_AND_TIME_RELATIVE_URL + "DatabaseName=" + dbName + "&BranchID=" + branchID + "&PickUpDate=" + encodedPickupDate + "&PickUpTime=" + encodedPickupTime
        
        
        
        
        let headers = ["token": "\(token)"] as [String:String]
        
        networkClient.callAPIWithAlamofire(apiname: apiname,
                                           requestType: .get,
                                           params: nil,
                                           headers: headers,
                                           success: { (data, httpResponse) in
                                            
                                            if let pickUpDateModel = decodeJSON(type: [PickUpDateModel].self, from: data) {
                                                completion(pickUpDateModel, "Success")
                                            }else{
                                                completion(nil,"failed")
                                            }
                                            
        }) { (error, message) in
            
            completion(nil,message)
            
        }
    }

    
    
}
