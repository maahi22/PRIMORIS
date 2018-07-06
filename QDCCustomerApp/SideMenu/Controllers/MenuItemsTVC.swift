//
//  MenuItemsWithHeaderVC.swift
//  I-Helper
//
//  Created by Kripa Tripathi on 17/11/17.
//  Copyright © 2017 Maxtra Technologies P LTD. All rights reserved.
//

import UIKit


class MenuItemsTVC: UITableViewController {
    
    @IBOutlet weak var menuHeaderView: UIView!
    @IBOutlet weak var menuHeaderImageView: UIImageView!
    
    @IBOutlet weak var menuHeaderTitleLabel: UILabel!
    
    
    var menuItems :[Section] = [Section]()
    let bgLayer = CAShapeLayer()
    
    func setUserProfileImage(_ image:UIImage)  {
        menuHeaderImageView.image = image
        menuHeaderImageView.contentMode = .scaleAspectFill
        menuHeaderImageView.layer.cornerRadius = menuHeaderImageView.frame.size.width / 2
        menuHeaderImageView.layer.masksToBounds = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        tableView.rowHeight = 35
        //tableView.setTableViewBackgroundGradient(#colorLiteral(red: 0.8705882353, green: 0.8509803922, blue: 0.7882352941, alpha: 1), #colorLiteral(red: 0.09929890186, green: 0.1892752349, blue: 0.70184201, alpha: 1))
        //tableView.separatorStyle = .none
        /*if let userImageData = UserDefaults.standard.data(forKey: "empayUserImageData"), let image = UIImage(data: userImageData) {
            
            setUserProfileImage(image)
        }*/
       /* if let user = getLoggedUser(), let userName = user.Name{
            menuHeaderTitleLabel.text = userName.capitalized
        }*/
        tableView.register(MenuItemTableViewCell.nib, forCellReuseIdentifier: MenuItemTableViewCell.identifier)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getMenuItems() { [weak self](menuItems) in
            guard let strongSelf = self else{return}
            strongSelf.menuItems = menuItems
            strongSelf.tableView.reloadData()
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //setup()
        //configure()
    }
    
}

extension MenuItemsTVC{
    
    
    
    class func getSideMenuImageArray() -> NSArray {
        return ["Side Offer Icons","Side My PickupsIcon","Side Request Pick Up Icon","Side Due Amount Icon","Side My Order Icon","Side Price List Icon","Offer Icon","Side Feedback Icon","Setting.png","Side Request Pick Up Icon"]
    }
    //MARK: - Menu Items Model
    fileprivate func getMenuItems(completion:([Section])->())  {
        let menuItems = [
            Section(name: "DASHBOARD", items: [], image: "sidebar_home", selImage: "", expanded: false,itemType:MenuItemType.home),
            Section(name: "REQUEST PICKUP", items: [], image: "sidebar_wallet", selImage: "", expanded: false,itemType:MenuItemType.card),
            Section(name: "MY REQUEST", items: [], image: "sidebar_moneytransfer", selImage: "", expanded: false,itemType:MenuItemType.none),
            // Section(name: "Fee Payment History", items: [], image: "", selImage: "", expanded: false,itemType:MenuItemType.feepaymenthistory),
            
            Section(name: "DUE AMOUNT", items: [], image: "sidebar_food", selImage: "", expanded: false,itemType:MenuItemType.food),
            Section(name: "MY ORDERS", items: [], image: "sidebar_education", selImage: "", expanded: false,itemType:MenuItemType.education),
            Section(name: "PRICE LIST", items: [], image: "sidebar_govermentpayments", selImage: "", expanded: false,itemType:MenuItemType.none),
            Section(name: "OFFERS", items: [], image: "sidebar_sdcardactivation", selImage: "", expanded: false,itemType:MenuItemType.none),
            Section(name: "FEEDBACK", items: ["A","B"], image: "contact_us", selImage: "", expanded: true,itemType:MenuItemType.none),
            Section(name: "SETTING", items: [], image: "user_profile", selImage: "", expanded: false,itemType:MenuItemType.profile),
            
            
            Section(name: "ABOUT US", items: [], image: "sidebar_signout", selImage: "", expanded: false,itemType:MenuItemType.signout)
        ]
        
        
        
        completion(menuItems)
    }
    
    
    //MARK: - Functions
    
    
    
    
    
    func setCenterView(index:Int)  {
        
        switch menuItems[index].itemType {
        case .home:
            
            sideMenuController?.performSegue(withIdentifier: SideMenuOptions.showHome.rawValue, sender: nil)
        case .signout:
            userLogout()
        case .card:
            sideMenuController?.performSegue(withIdentifier: SideMenuOptions.showCard.rawValue, sender: nil)
        case .food:
            sideMenuController?.performSegue(withIdentifier: SideMenuOptions.showRestaurant.rawValue, sender: nil)
        case .education:
            sideMenuController?.performSegue(withIdentifier: SideMenuOptions.showEducation.rawValue, sender: nil)
        case .feepaymenthistory:
            sideMenuController?.performSegue(withIdentifier: SideMenuOptions.showFeePaymentHistory.rawValue, sender: nil)
        case .orderhistory:
            sideMenuController?.performSegue(withIdentifier: SideMenuOptions.showOrderHistory.rawValue, sender: nil)
        case .mywallet:
            sideMenuController?.performSegue(withIdentifier: SideMenuOptions.showMyWallet.rawValue, sender: nil)
        case .profile:
            sideMenuController?.performSegue(withIdentifier: SideMenuOptions.showProfile.rawValue, sender: nil)
            
            //profileOptions()
        case .contact:
            print("Contact")
        case .email:
            print("Email")
        case .none:
            print("none")
        }
    }
    
    func userLogout()  {
    }
    
    func profileOptions()  {
        let alertController = UIAlertController.init(title: "User Profile", message: nil, preferredStyle: .actionSheet)
        //Logout Action
        let changePasswordAction = UIAlertAction.init(title: "Change PIN", style: .default){
            [weak self] action in
            guard let strongSelf = self else{return}
           
            
        }
        
        //Logout Action
        let changeSecurityQuesAction = UIAlertAction.init(title: "Change Security Question", style: .default){
            [weak self] action in
            guard let strongSelf = self else{return}
           
        }
        //Cancel Action
        let cancelAction = UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(changePasswordAction)
        
        alertController.addAction(changeSecurityQuesAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    
}

extension MenuItemsTVC{
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MenuItemTableViewCell.identifier, for: indexPath) as? MenuItemTableViewCell else { return UITableViewCell() }
        cell.menuItem = menuItems[indexPath.row]
        return cell
    }
}

extension MenuItemsTVC{
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        setCenterView(index: indexPath.row)
    }
}











