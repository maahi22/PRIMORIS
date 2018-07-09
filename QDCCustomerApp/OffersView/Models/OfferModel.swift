//
//  OfferModel.swift
//  QDCCustomerApp
//
//  Created by Maahi on 09/07/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import Foundation


struct OfferModel:Codable{
    let DatabaseName:String?
    let BranchID:String?
    let Pincode:String?
    let Locality:String?
    let SubLocality:String?
    let CountryCode:String?
    let PackageName:String?
    let ClientID:String?
}
