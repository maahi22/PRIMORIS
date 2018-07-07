//
//  PickUpDateModel.swift
//  QDCCustomerApp
//
//  Created by Amit Pant on 07/07/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import Foundation
/*{
"PickUpDate": "09 Jul 2018",
"PickUpTime": [
{
"Slots": "11:00 AM - 12:30 PM"
},
{
"Slots": "12:30 PM - 2:00 PM"
},
{
"Slots": "2:00 PM - 3:30 PM"
},
{
"Slots": "3:30 PM - 5:00 PM"
},
{
"Slots": "5:00 PM - 6:30 PM"
},
{
"Slots": "6:30 PM - 8:00 PM"
},
{
"Slots": "8:00 PM - 9:30 PM"
}
]
}*/

struct PickUpDateModel:Codable {
    let PickUpDate:String
    let PickUpTime:[PickUpTimeModel]
}

struct PickUpTimeModel:Codable {
    let Slots:String
}
