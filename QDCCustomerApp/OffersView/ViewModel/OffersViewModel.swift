//
//  OffersViewModel.swift
//  QDCCustomerApp
//
//  Created by Maahi on 09/07/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import UIKit

class OffersViewModel: NSObject {

    @IBOutlet private var offersClient:OffersClient!
    var offers:[OfferModel]?
    
    
    func getOffers(completion:@escaping(Bool,String)->())  {
        offersClient.getOffers { [weak self](OfferModel, message) in
            guard let strongSelf = self else{return}
            if let offerModel = OfferModel{
                //strongSelf.offers = offerModel
               // let selectedDate = pickUpDateModels[0].PickUpDate
               // let dates =  CommonUtilities.getTwoPreviousDaysFromString(dateString: selectedDate)
               // strongSelf.pickUpDates?.insert(dates.dayTwo, at: 0)
               // strongSelf.pickUpDates?.insert(dates.dayOne, at: 1)
                
                completion(true,"Success")
            }else{
                completion(false,message)
            }
            
        }
    }
    
    
    
    func numberOffers() -> Int {
        guard let offers = offers else { return 0 }
        return offers.count
    }
    
   /* func offersAt(for cellAtIndex:IndexPath) -> String? {
        guard let offers = offers else { return nil }
        return offers[cellAtIndex.item].PickUpDate
        
    }*/
    
}
