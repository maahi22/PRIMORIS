//
//  SignUpChoiceVC.swift
//  QDCCustomerApp
//
//  Created by Amit Pant on 21/06/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import UIKit

class SignUpChoiceVC: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var mobileButon: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        let cornerRadius = imageView.frame.width/2
        imageView.layer.cornerRadius = cornerRadius
        imageView.clipsToBounds = true
        
        facebookButton.setButtonTheme()
        mobileButon.setButtonTheme()
        // Do any additional setup after loading the view.
    }

    @IBAction func mobileSignUpPressed(_ sender: UIButton) {
        guard let navViewController = SignUpTVC.getStoryboardInstance(),
            let viewController = navViewController.topViewController as? SignUpTVC
            else { return  }
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }

    @IBAction func backPressed(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension SignUpChoiceVC{
    
    static func getStoryboardInstance() -> UINavigationController?{
        let storyborad = UIStoryboard(name: String(describing: self), bundle: nil)
        guard let navViewController = storyborad.instantiateInitialViewController()  as? UINavigationController  else { return nil }
        return navViewController
    }
}
