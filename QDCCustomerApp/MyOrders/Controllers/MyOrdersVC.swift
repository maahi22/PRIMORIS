//
//  MyOrdersVC.swift
//  QDCCustomerApp
//
//  Created by Amit Pant on 04/07/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import UIKit

class MyOrdersVC: UIViewController {

    
    
    @IBOutlet private var myOrderViewModel:MyOrderViewModel!
    
    
    @IBOutlet weak var orderTableView: UITableView!
    @IBOutlet weak var pendingOrderLabel:UILabel!
    @IBOutlet weak var inProcessLabel:UILabel!
    @IBOutlet weak var dueLabel:UILabel!
    @IBOutlet weak var readyLabel:UILabel!
    @IBOutlet weak var dueImageView:UIImageView!
    @IBOutlet weak var readyImageView:UIImageView!
    @IBOutlet weak var processImageView:UIImageView!
    
    var orderArray:NSArray = NSArray()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.registerNib()
        self.setupUI()
        
        
        
        
        myOrderViewModel.getMyOrder { [weak self] (isSuccess, message) in
            guard let strongSelf = self else{return}
            
            if isSuccess {
                DispatchQueue.main.async {
                    
                    if let totalord = strongSelf.myOrderViewModel.orderModel {
                        if let val = totalord[0].orderSummaryModel{
                            strongSelf.pendingOrderLabel.text = val[0].TotalOrder
                        }
                        
                    }
                    
                    if let totalord = strongSelf.myOrderViewModel.orderModel {
                        if let val = totalord[0].orderSummaryModel{
                            strongSelf.pendingOrderLabel.text = val[0].ProcessCloth
                        }
                        
                    }
                    
                    if let totalord = strongSelf.myOrderViewModel.orderModel {
                        if let val = totalord[0].orderSummaryModel{
                            strongSelf.pendingOrderLabel.text = val[0].TotalAmount
                        }
                        
                    }
                    
                    if let totalord = strongSelf.myOrderViewModel.orderModel {
                        if let val = totalord[0].orderSummaryModel{
                            strongSelf.pendingOrderLabel.text = val[0].ReadyCloth
                        }
                        
                    }
                    
                    
                    
                    
                    
                    /*if let processCloth = strongSelf.myOrderViewModel.orderSummaryModel?.ProcessCloth {
                        strongSelf.inProcessLabel.text = processCloth
                    }
                    
                    if let totalAmount = strongSelf.myOrderViewModel.orderSummaryModel?.TotalAmount {
                        strongSelf.dueLabel.text = totalAmount
                    }
                    
                    if let readyCloth = strongSelf.myOrderViewModel.orderSummaryModel?.ReadyCloth {
                        strongSelf.readyLabel.text = readyCloth
                    }*/
                    
                    
                   
                   
                    strongSelf.orderTableView.reloadData()
                    
                }
                
            }else{
                showAlertMessage(vc: strongSelf, title: .Error, message: message)
            }
            
        }
        
        
        
    }

    
    func registerNib() {
        orderTableView.register(MyOrderCell.nib, forCellReuseIdentifier: MyOrderCell.identifier)
    }
    
    func setupUI() {
        
        self.view.backgroundColor = PRIMARY_COLOUR
        self.orderTableView.backgroundColor =  UIColor.white
        
        self.dueImageView.image = self.dueImageView.image!.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        self.dueImageView.tintColor = APP_ICON_COLOUR
        self.readyImageView.image = self.readyImageView.image!.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        self.readyImageView.tintColor = APP_ICON_COLOUR
        self.processImageView.image = self.processImageView.image!.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        self.processImageView.tintColor = APP_ICON_COLOUR
 
    }
    

}

extension MyOrdersVC{
    static func getStoryboardInstance() -> UINavigationController?{
        let storyborad = UIStoryboard(name: String(describing: self), bundle: nil)
        guard let navViewController = storyborad.instantiateInitialViewController()  as? UINavigationController else { return nil }
        return navViewController
    }
}


extension MyOrdersVC:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myOrderViewModel.numberOfmyOrder()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = orderTableView.dequeueReusableCell(withIdentifier: MyOrderCell.identifier, for: indexPath)  as? MyOrderCell else { return UITableViewCell() }
       
        cell.myOrderModel =  myOrderViewModel.myOrderForIndexPath(indexPath)
        return cell
    }
}

extension MyOrdersVC:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let orderDetailObj = myOrderViewModel.myOrderForIndexPath(indexPath) {
            guard let navViewController = OrderDetailVC.getStoryboardInstance(),
                let  viewController = navViewController.topViewController as? OrderDetailVC
                else { return  }
            viewController.orderDetailModelObj = orderDetailObj
            self.navigationController?.pushViewController(viewController, animated: true)
    
    }
    
}
    
    
    
}
