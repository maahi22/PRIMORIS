//
//  MyOrdersVC.swift
//  QDCCustomerApp
//
//  Created by Amit Pant on 04/07/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import UIKit

class MyOrdersVC: UIViewController {

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
        //self.setNavigationBar(MY_ORDER_TITLE, leftHidden: false, rightHidden: false)
    }

    
    func registerNib() {
        //let cellName = UINib(nibName: "QDCOrderTableViewCell", bundle:nil)
        //orderTableView.registerNib(cellName, forCellReuseIdentifier: orderCellIdentier)
    }
    
    func setupUI() {
        
       /* self.view.backgroundColor = PRIMARY_COLOUR
        self.orderTableView.backgroundColor =  UIColor.whiteColor()
        
        self.dueImageView.image = self.dueImageView.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        self.dueImageView.tintColor = APP_ICON_COLOUR
        self.readyImageView.image = self.readyImageView.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        self.readyImageView.tintColor = APP_ICON_COLOUR
        self.processImageView.image = self.processImageView.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        self.processImageView.tintColor = APP_ICON_COLOUR
        */
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
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = orderTableView.dequeueReusableCell(withIdentifier: ServiceAreaTableViewCell.identifier, for: indexPath)  as? ServiceAreaTableViewCell else { return UITableViewCell() }
       // cell.serviceArea = serviableAreaViewModel.servicableAreaForIndexPath(indexPath)
        return cell
    }
}

extension MyOrdersVC:UITableViewDelegate{
    /*func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let selectedServiceArea = serviableAreaViewModel.servicableAreaForIndexPath(indexPath) else{
            return
        }
        
        QDCUserDefaults.setBranchId(branchId: selectedServiceArea.BranchID ?? "")
        QDCUserDefaults.setClientID(clientID: selectedServiceArea.ClientID ?? "")
        let serviceArea = try? JSONEncoder().encode(selectedServiceArea)
        
        UserDefaults.standard.set(serviceArea, forKey: "SelectedServiceArea")
        
        navigateToSignUpChoice()
        
    }*/
}
