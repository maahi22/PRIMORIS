//
//  FeedBackVC.swift
//  QDCCustomerApp
//
//  Created by Maahi on 07/07/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import UIKit

class FeedBackVC: UIViewController {

    @IBOutlet weak var feedbackTextView:UITextView!
    @IBOutlet weak var countLabel:UILabel!
    @IBOutlet weak var feedbackLabel:UILabel!
    @IBOutlet weak var sendButton: UIButton!
    var hideMenuOnNav:Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    
    
    @IBAction func sendButtonClick(sender: AnyObject) {
        
        self.hitFeedbackWebService()
    }
    
    
    func hitFeedbackWebService() {
       /* var tempDict:[String:AnyObject]? = nil
        tempDict = ["CustomerCode":QDCUserDefaults.getCustomerId(), "DatabaseName": QDCUserDefaults.getDataBaseName(),"Message": self.feedbackTextView.text!,"BranchID":QDCUserDefaults.getBranchId()]
        let dict:NSDictionary? = NSDictionary.init(object: tempDict!, forKey: kWebServicePostParamKey)
        QDCFeedbackWebService.hitApi(dict!, responseValue: { (isSuccess, response,header, error) ->
            Void in
            if isSuccess{
                
                self.feedbackTextView.text = ""
                self.feedbackLabel.hidden = false
                
                let alert:UIAlertView = UIAlertView(title:"" , message: "Thank you for your valuable feedback", delegate: self, cancelButtonTitle: "ok")
                alert.show()
                
            }else{
                
            }
        })*/
    }
    
   /* func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        
        let controller = UIStoryboard.addDashBoardViewController() as QDCDashboardViewController
        let navigationController = UINavigationController(rootViewController: controller)
        navigationController.navigationBarHidden = true
        self.revealViewController().pushFrontViewController(navigationController, animated: true)
    }
    
    */
    
}


extension FeedBackVC:UITextViewDelegate{
    func textViewDidBeginEditing(textView:UITextView) {   //delegate method
        
        textView.text = "";
        self.feedbackLabel.isHidden = true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if textView.text.count >= 1000 {
            
            return false
        }
        
        self.countLabel.text = "\(textView.text.count)/1000 Max Characters"
        
        return true
    }
}

extension FeedBackVC{
    static func getStoryboardInstance() -> UINavigationController?{
        let storyborad = UIStoryboard(name: String(describing: self), bundle: nil)
        guard let navViewController = storyborad.instantiateInitialViewController()  as? UINavigationController else { return nil }
        return navViewController
    }
}
