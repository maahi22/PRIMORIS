//
//  DropOffViewModel.swift
//  QDCCustomerApp
//
//  Created by Maahi on 10/07/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import UIKit

class DropOffViewModel: NSObject {

    @IBOutlet private var dropOffClient:DropOffClient!
    var pickUpDates:[PickUpDateModel]?
    
    func getDropOff(pickupDateKey:String ,pickupTimeKey:String, completion:@escaping(Bool,String)->())  {
        dropOffClient.fetchDropOff(pickupDateKey,pickupTimeKey) { [weak self](pickUpDateModels, message) in
            guard let strongSelf = self else{return}
            if let pickUpDateModels = pickUpDateModels{
                strongSelf.pickUpDates = pickUpDateModels
                let selectedDate = pickUpDateModels[0].PickUpDate
                let dates =  CommonUtilities.getTwoPreviousDaysFromString(dateString: selectedDate)
                strongSelf.pickUpDates?.insert(dates.dayTwo, at: 0)
                strongSelf.pickUpDates?.insert(dates.dayOne, at: 1)
                
                completion(true,"Success")
            }else{
                completion(false,message)
            }
            
        }
    }
    
    
    
}
