//
//  OrderDetailVC.swift
//  QDCCustomerApp
//
//  Created by Maahi on 07/07/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import UIKit

class OrderDetailVC: UIViewController {

    
    @IBOutlet private var orderDetailViewModel:OrderDetailViewModel!
    
    @IBOutlet weak var orderDetailTableView: UITableView!
    
    @IBOutlet weak var orderLabel:UILabel!
    @IBOutlet weak var dueDateLabel:UILabel!
    @IBOutlet weak var totalPriceLabel:UILabel!
    @IBOutlet weak var totalClothsLabel:UILabel!
    @IBOutlet weak var pendingPriceLabel:UILabel!
    @IBOutlet weak var pendingClothsLabel:UILabel!
    
    @IBOutlet weak var orderImageView:UIImageView!
    @IBOutlet weak var dateImageView:UIImageView!
    @IBOutlet weak var totalPriceImageView:UIImageView!
    @IBOutlet weak var totalClothImageView:UIImageView!
    @IBOutlet weak var pendingPriceImageView:UIImageView!
    @IBOutlet weak var pendingClothImageView:UIImageView!
    
    
    @IBOutlet weak var scheduleButton:UIButton!
    
    var orderDetailModelObj:OrderDetailsModel!
    var orderDetailArray:NSArray = NSArray()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
        
        orderDetailTableView.register(OrderDetailCell.nib, forCellReuseIdentifier: OrderDetailCell.identifier)
        
        
        
        orderDetailViewModel.getMyOrder(orderDetailModelObj.OrderNo!, completion: {  [weak self] (isSuccess, message) in
            
            guard let strongSelf = self else{return}
            
            if isSuccess {
                DispatchQueue.main.async {
                    strongSelf.orderDetailTableView.reloadData()
                    
                }
                
            }else{
                showAlertMessage(vc: strongSelf, title: .Error, message: message)
            }
            
            
        })
        
        
    }

    func setupUI() {
        
        self.view.backgroundColor = PRIMARY_COLOUR
        self.orderDetailTableView.backgroundColor = UIColor.white
        
        self.orderLabel.text = orderDetailModelObj.OrderNo
        self.dueDateLabel.text = orderDetailModelObj.OrderDate
        self.totalPriceLabel.text = orderDetailModelObj.TotalAmount
        self.totalClothsLabel.text = orderDetailModelObj.TotalGarments
        self.pendingPriceLabel.text = orderDetailModelObj.PendingAmount
        self.pendingClothsLabel.text = orderDetailModelObj.PendingGarment
        
        self.scheduleButton.setTitleColor(COLOUR_ON_BUTTON, for: UIControlState.normal)
        self.scheduleButton.backgroundColor = BUTTON_COLOUR
        
        
        self.totalPriceImageView.image = self.totalPriceImageView.image!.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        self.totalPriceImageView.tintColor = APP_ICON_COLOUR
        self.totalClothImageView.image = self.totalClothImageView.image!.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        self.totalClothImageView.tintColor = APP_ICON_COLOUR
        self.pendingPriceImageView.image = self.pendingPriceImageView.image!.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        self.pendingPriceImageView.tintColor = APP_ICON_COLOUR
        self.pendingClothImageView.image = self.pendingClothImageView.image!.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        self.pendingClothImageView.tintColor = APP_ICON_COLOUR
    }

}





extension OrderDetailVC{
    static func getStoryboardInstance() -> UINavigationController?{
        let storyborad = UIStoryboard(name: String(describing: self), bundle: nil)
        guard let navViewController = storyborad.instantiateInitialViewController()  as? UINavigationController else { return nil }
        return navViewController
    }
}



extension OrderDetailVC:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderDetailViewModel.numberOfmyOrder()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = orderDetailTableView.dequeueReusableCell(withIdentifier: OrderDetailCell.identifier, for: indexPath)  as? OrderDetailCell else { return UITableViewCell() }
        
        cell.myOrderDetailModel =  orderDetailViewModel.myOrderForIndexPath(indexPath)
        return cell
    }
    
    private func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 0.1))
        footerView.backgroundColor = UIColor.clear
        return footerView
    }
    
    
}

extension OrderDetailVC:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    private func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: IndexPath) -> CGFloat {
        
        return 82
    }

}

