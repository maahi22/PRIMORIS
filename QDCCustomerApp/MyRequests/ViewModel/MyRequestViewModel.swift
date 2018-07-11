//
//  MyRequestViewModel.swift
//  QDCCustomerApp
//
//  Created by Maahi on 10/07/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import UIKit

class MyRequestViewModel: NSObject {

    @IBOutlet private var myRequestClient:MyRequestClient!
    var myRequestModel:[MyRequestModel]?
    
    
    func getMyRequest(completion:@escaping(Bool,String)->())  {
        
        myRequestClient.fetchMyRequest { [weak self] (myRequestModel, message) in
            guard let strongSelf = self else{return}
            if let myRequestModel = myRequestModel{
                strongSelf.myRequestModel = myRequestModel
                completion(true,message)
            }else{
                completion(false,message)
            }
        }
    }
    
    
    
    func numberMyRequest() -> Int {
        guard let myRequestModel = myRequestModel else { return 0 }
        return myRequestModel.count
    }
    
    
    func myRequestAt(for cellAtIndex:IndexPath) -> MyRequestModel? {
        guard let myRequestModel = myRequestModel else { return nil }
        return myRequestModel[cellAtIndex.row]
        
    }
    
    
}
