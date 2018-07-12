//
//  PriceListVC.swift
//  QDCCustomerApp
//
//  Created by Maahi on 07/07/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import UIKit

class PriceListVC: UIViewController {

    @IBOutlet var priceListViewModel:PriceListViewModel!
    
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

        
        self.setupUI()
        self.registerNib()
        
        
        priceListViewModel.getPriceList { [weak self] (isSuccess, message) in
            
            guard let strongSelf = self else{return}
            
            if isSuccess {
                DispatchQueue.main.async {
                    strongSelf.categorySelectionCollectionView.reloadData()
                    strongSelf.priceCollectionView.reloadData()
                }
                
            }else{
                showAlertMessage(vc: strongSelf, title: .Error, message: message)
            }
            
            
        }
    }

    
    func setupUI() {
        
        self.showCategoryButton.setTitleColor(UIColor.darkGray, for: UIControlState.normal)
        self.showCategoryButton.layer.cornerRadius = 5
        self.showCategoryButton.layer.borderColor = UIColor.lightGray.cgColor
        self.showCategoryButton.layer.borderWidth = 1
    }
    
    
    @IBAction func showCategoryButtonClick(_ sender: Any) {
    
        
        /*if self.garmentServicesArray.count > 0 {

            let tempArr = NSMutableArray.init(array:self.garmentServicesArray)
        
            let actionSheet = UIActionSheet(title: "Please select service", delegate: self, cancelButtonTitle:nil, destructiveButtonTitle: nil, otherButtonTitles:self.garmentServicesArray[0] as! String)
            tempArr.removeObjectAtIndex(0)

            for buttonTitle in tempArr {
                actionSheet.addButtonWithTitle(buttonTitle as? String)
            }

            actionSheet.showInView(self.view)
        
        }*/
    
    }
    
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        
//        self.selectedService = self.garmentServicesArray[buttonIndex] as! String
//
//        self.showCategoryButton.setTitle(self.selectedService, forState: UIControlState.Normal)
//
//        self.categorySelectionCollectionView.reloadData()
//        self.priceCollectionView.reloadData()
    }
    
    
    
    
    
    func registerNib() {
        
        categorySelectionCollectionView.register(PriceCategoryCollectionCell.nib, forCellWithReuseIdentifier: PriceCategoryCollectionCell.identifier)
        
        priceCollectionView.register(PriceCollectionCell.nib, forCellWithReuseIdentifier: PriceCollectionCell.identifier)
    }
  
}

extension PriceListVC{
    static func getStoryboardInstance() -> UINavigationController?{
        let storyborad = UIStoryboard(name: String(describing: self), bundle: nil)
        guard let navViewController = storyborad.instantiateInitialViewController()  as? UINavigationController else { return nil }
        return navViewController
    }
}



extension PriceListVC :UICollectionViewDelegate{
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        if collectionView.tag == 1 {
            
            self.selectedCategory = self.categoryArr[indexPath.row] as! String
            self.priceCollectionView.scrollToItem(at: indexPath as IndexPath, at: UICollectionViewScrollPosition.left, animated: true)
            self.categorySelectionCollectionView.reloadData()
            
        }
    }
}


extension PriceListVC : UICollectionViewDataSource {
    
    
    // MARK: - UICollectionViewDataSource protocol
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.categoryArr.count //items
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView.tag == 1 {

            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PriceCategoryCollectionCell.identifier, for: indexPath as IndexPath) as? PriceCategoryCollectionCell else { return UICollectionViewCell() }
            
            
//            let str = self.categoryArr[indexPath.row] as? String
//            cell.categoryLabel.text = str
//            cell.categoryLabel.textColor = UIColor.whiteColor()
//
//            if str == self.selectedCategory {
//                cell.selectedView.backgroundColor = PRIMARY_COLOUR
//                cell.categoryLabel.textColor = UIColor.blackColor()
//            }else{
//                cell.categoryLabel.textColor = UIColor.grayColor()
//                cell.selectedView.backgroundColor = UIColor.clearColor()
//            }
            
            return cell
            
        }else{
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PriceCollectionCell.identifier, for: indexPath as IndexPath) as? PriceCollectionCell else { return UICollectionViewCell() }
            
           
//
//            let dictKey:String = self.categoryArr[indexPath.row] as! String
//            let arr:NSArray = self.responseGarmentDict[dictKey] as! NSArray
//            cell.setupUI(arr, selectedService: self.selectedService)
            
            return cell
        }
        
    }
}


extension PriceListVC :UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var cellSize:CGSize!
        
        if collectionView.tag == 1 {
            cellSize = CGSize(width: 100, height: 50)
        }else{
            
            cellSize = CGSize(width: SCREEN_SIZE.width, height: SCREEN_SIZE.height-154)
            
        }
        
        return cellSize
    }
}



