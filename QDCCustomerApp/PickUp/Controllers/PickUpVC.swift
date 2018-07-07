//
//  PickUpVC.swift
//  QDCCustomerApp
//
//  Created by Maahi on 06/07/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import UIKit

class PickUpVC: UIViewController {

    @IBOutlet weak var timeSelectionCollectionView:UICollectionView!
    @IBOutlet weak var dateSelectionCollectionView:UICollectionView!
    @IBOutlet weak var specialInstructionTextView:UITextView!
    @IBOutlet weak var firstButton:UIButton!
    @IBOutlet weak var secondButton:UIButton!
    @IBOutlet weak var firstButtonRadioImage:UIImageView!
    @IBOutlet weak var secondButtonRadioImage:UIImageView!
    @IBOutlet weak var schedulePickupButton:UIButton!
    @IBOutlet weak var containerScrollView:UIScrollView!
    @IBOutlet weak var timeCollectionBottomConstraint:NSLayoutConstraint!
    
    var pickupNumber:String = ""
    var showDropOff:Bool = false
    var requireDropOff:Bool = false
    var selectedDate:String = ""
    var selectedTime:String = ""
    var pickUpScheduleArray:NSMutableArray = NSMutableArray()
    var selectedDateIndex : Int = 2
    var selectedExpressDeliveryButton : Int = 0  //0 means none of them is selected 1 means first is selected 2 means second is selected
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    

}



extension PickUpVC{
    static func getStoryboardInstance() -> UINavigationController?{
        let storyborad = UIStoryboard(name: String(describing: self), bundle: nil)
        guard let navViewController = storyborad.instantiateInitialViewController()  as? UINavigationController else { return nil }
        return navViewController
    }
}




extension PickUpVC:UICollectionViewDelegate{
    
}

extension PickUpVC:UICollectionViewDelegateFlowLayout{
    
}

extension PickUpVC:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if collectionView.tag == 1 {
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DateCollectionViewCell.identifier, for: indexPath) as? DateCollectionViewCell else { return UICollectionViewCell() }
            //cell.serviceArea = serviableAreaViewModel.servicableAreaForIndexPath(indexPath)
           
            
            
            return cell
        }else{
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TimeCollectionViewCell.identifier, for: indexPath) as? TimeCollectionViewCell else { return UICollectionViewCell() }
            
           return cell
        }
    }
    
    
}
