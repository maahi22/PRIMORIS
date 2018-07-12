//
//  MyDropOffViewModel.swift
//  QDCCustomerApp
//
//  Created by Maahi on 10/07/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import UIKit

class MyDropOffViewModel: NSObject {

    
    @IBOutlet private var myDropOffClient:MyDropOffClient!
    var dropOffModel:[MyRequestDropOffModel]?
    
    
    func getDropOff(completion:@escaping(Bool,String)->())  {
        
        myDropOffClient.fetchMyDropOff { [weak self] (dropOffModel, message) in
            guard let strongSelf = self else{return}
            if let dropOffModel = dropOffModel{
                strongSelf.dropOffModel = dropOffModel
                completion(true,message)
            }else{
                completion(false,message)
            }
        }
    }
    
    
    
    func numberMyRequestDropOff() -> Int {
        guard let dropOffModel = dropOffModel else { return 0 }
        return dropOffModel.count
    }
    
    
    func myRequestDropOffAt(for cellAtIndex:IndexPath) -> MyRequestDropOffModel? {
        guard let dropOffModel = dropOffModel else { return nil }
        return dropOffModel[cellAtIndex.row]
        
    }
    
    
}
