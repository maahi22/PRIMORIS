//
//  Section.swift
//  IMMTradersClub
//
//  Created by Maxtra Technologies P LTD on 19/09/17.
//  Copyright © 2017 Maxtra Technologies P LTD. All rights reserved.
//

import Foundation
enum MenuItemType{
    case home
    case card
    case food
    case education
    case orderhistory
    case mywallet
    case contact
    case email
    case signout
    case feepaymenthistory
    case none
    case profile
}
struct Section {
    
    let name:String
    let items:[String]
    let image:String
    let selImage:String
    let expanded:Bool
    let itemType:MenuItemType
  
}
