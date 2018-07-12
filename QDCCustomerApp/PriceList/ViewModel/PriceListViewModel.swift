//
//  PriceListViewModel.swift
//  QDCCustomerApp
//
//  Created by Maahi on 10/07/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import UIKit

class PriceListViewModel: NSObject {

    @IBOutlet private var priceListClient:PriceListClient!
    var priceListModel:[PriceListModel]?
    let servicesArr = NSMutableArray()
    
    
    func getPriceList(completion:@escaping(Bool,String)->())  {
        
        priceListClient.fetchPriceList { [weak self] (priceListModel, message) in
            guard let strongSelf = self else{return}
            if let priceListModel = priceListModel{
                strongSelf.priceListModel = priceListModel
                completion(true,message)
            }else{
                completion(false,message)
            }
        }
        
    }
    
    func numberOfPriceList() -> Int {
        guard let priceListModel = priceListModel else { return 0 }
        return priceListModel.count
    }
    
    func priceListForIndexPath(_ indexPath:IndexPath) -> PriceListModel? {
        guard let priceListModel = priceListModel else { return nil }
        return priceListModel[indexPath.row]
    }
    
    
}
