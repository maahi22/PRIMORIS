//
//  PriceListModel.swift
//  QDCCustomerApp
//
//  Created by Maahi on 09/07/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import Foundation


struct PriceListModel:Codable {
    
    /*let Garment:String?
    let Dry_Cleaning:String?
    let Steam_Press:String?
    let TINTORERIA:String?*/
    let PriceListGarment:[PriceListGarmentModel]
}


struct PriceListGarmentModel:Codable {
    let Garment:String
}
