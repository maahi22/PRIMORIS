//
//  PickUpDateClient.swift
//  QDCCustomerApp
//
//  Created by Amit Pant on 07/07/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import Foundation

class PickUpDateClient: NSObject {
    // MARK: - Injections
    internal let networkClient = NetworkClient.shared
    
    //pick up date
    func getPickUpDate(completion:@escaping ([PickUpDateModel]?,String)->())  {
        
        let clientID = QDCUserDefaults.getClientID()
        let branchID = QDCUserDefaults.getBranchId()
        let token = QDCUserDefaults.getAccessToken()
        
        let apiname = PICKUP_DATE_RELATIVE_URL + "\(clientID)/\(branchID)"
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

    //schedule details
    func getScheduleDetails(completion:@escaping (ScheduleDetailsModel?,String)->())  {
        
        let clientID = QDCUserDefaults.getClientID()
        let branchID = QDCUserDefaults.getBranchId()
        let token = QDCUserDefaults.getAccessToken()
        
        let apiname = SCHEDULE_DETAILS_RELATIVE_URL + "\(clientID)/\(branchID)"
        let headers = ["token": "\(token)"] as [String:String]
        
        networkClient.callAPIWithAlamofire(apiname: apiname,
                                           requestType: .get,
                                           params: nil,
                                           headers: headers,
                                           success: { (data, httpResponse) in
                                            
                                            if let scheduleDetailsModel = decodeJSON(type: ScheduleDetailsModel.self, from: data) {
                                                completion(scheduleDetailsModel, "Success")
                                            }else{
                                                completion(nil,"failed")
                                            }
                                            
        }) { (error, message) in
            
            completion(nil,message)
            
        }
    }

    
    //schedule details
    func getSchedulePickup( pickupDate:String,
                            pickupTime:String,
                            flag:Int,
                            pickupNumber:String,
                            expressDeliveryID:String,
                            specialInstruction:String,
                            dropOffDate:String,
                            dropOffTime:String,
                            cancelReason:String?,
        completion:@escaping (SchedulePickupModel?,String)->())  {
        
        let clientID = QDCUserDefaults.getClientID()
        let branchID = QDCUserDefaults.getBranchId()
        let customerCode = QDCUserDefaults.getCustomerId()
        let token = QDCUserDefaults.getAccessToken()
        
        var params = ["ClientID": clientID,
                      "BranchID":branchID,
                      "CustomerCode": customerCode,
                      "PickupDate" :pickupDate,
                      "PickupTime" : pickupTime,
                      "Flag":flag ,
                      "PickupNumber":pickupNumber,
                      "ExpressDeliveryID":expressDeliveryID,
                      "SpecialInstruction":specialInstruction,
                      "DropOffDate":dropOffDate,
                      "DropOffTime":dropOffTime] as [String:Any]
        if let cancelReason = cancelReason {
            params["CancelReason"] = cancelReason
        }
        let headers = ["token": "\(token)", "Content-Type": "application/json"] as [String:String]
        
        networkClient.callAPIWithAlamofire(apiname: nil,
                                           requestType: .post,
                                           params: params,
                                           headers: headers,
                                           success: { (data, httpResponse) in
                                            
                                            if let scheduleDetailsModel = decodeJSON(type: SchedulePickupModel.self, from: data) {
                                                completion(scheduleDetailsModel, "Success")
                                            }else{
                                                completion(nil,"failed")
                                            }
                                            
        }) { (error, message) in
            
            completion(nil,message)
            
        }
    }
}
