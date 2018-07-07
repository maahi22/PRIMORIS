//
//  PriceListVC.swift
//  QDCCustomerApp
//
//  Created by Maahi on 07/07/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import UIKit

class PriceListVC: UIViewController {

    @IBOutlet weak var categorySelectionCollectionView:UICollectionView!
    @IBOutlet weak var priceCollectionView:UICollectionView!
    @IBOutlet weak var showCategoryButton:UIButton!
    
  //  var garmentServicesArray = [];
    var selectedService:String = ""
    var selectedCategory:String = ""
    var responseGarmentDict:NSDictionary = [String:[NSDictionary]]() as NSDictionary
    var categoryArr = NSArray()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension PriceListVC{
    static func getStoryboardInstance() -> UINavigationController?{
        let storyborad = UIStoryboard(name: String(describing: self), bundle: nil)
        guard let navViewController = storyborad.instantiateInitialViewController()  as? UINavigationController else { return nil }
        return navViewController
    }
}
