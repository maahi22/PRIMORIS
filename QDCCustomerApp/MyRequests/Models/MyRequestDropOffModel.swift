//
//  DropOffModel.swift
//  QDCCustomerApp
//
//  Created by Maahi on 10/07/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import Foundation

struct MyRequestDropOffModel:Codable{
//    let Title:String?
//    let Descreption:String?
    var dropOffNumber : String?
    var dropOffDate : String?
    var dropOffTime : String?
    var status : String?
    var pickUpNumber : String?
    var pickUpDate : String?
    var history : [DropoffHistoryModel]? //this will be the array of dropoffHistory model
    
}
