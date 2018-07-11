//
//  DropOffVC.swift
//  QDCCustomerApp
//
//  Created by Maahi on 07/07/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import UIKit

class DropOffVC: UIViewController {

    @IBOutlet private var dropOffViewModel:DropOffViewModel!
    
    @IBOutlet weak var timeSelectionCollectionView:UICollectionView!
    @IBOutlet weak var dateSelectionCollectionView:UICollectionView!
    @IBOutlet weak var scheduleDropOffButton:UIButton!
    @IBOutlet weak var skipDropOffButton:UIButton!
    @IBOutlet weak var scheduleButtonWidthConstraint:NSLayoutConstraint!
    @IBOutlet weak var skipButtonWidthConstraint:NSLayoutConstraint!
    
    var pickupNumber:String = ""
    var dropoffNumber:String = ""
    var bookingId:String = ""
    var requireDropOff:Bool = true
    var selectedPickupDate:String = ""
    var selectedPickupTime:String = ""
    var selectedDropOffDate:String = ""
    var selectedDropOffTime:String = ""
    var pickUpInstruction:String = ""
    var isComingFromPickUp = false // this means hit schedule pick up api and not drop off api
    var dropOffUpScheduleArray:NSMutableArray = NSMutableArray()
    var selectedDateIndex : Int = 2
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dateSelectionCollectionView.register(DateCollectionViewCell.nib, forCellWithReuseIdentifier: DateCollectionViewCell.identifier)
        
        timeSelectionCollectionView.register(TimeCollectionViewCell.nib, forCellWithReuseIdentifier: TimeCollectionViewCell.identifier)
        self.setupUI()
        
        
        dropOffViewModel.getDropOff(pickupDateKey: self.selectedPickupDate, pickupTimeKey: self.selectedPickupTime) { [weak self] (isSuccess, message) in
            
            guard let strongSelf = self else{return}
            
            if isSuccess {
                DispatchQueue.main.async {
                    
                    strongSelf.dateSelectionCollectionView.reloadData()
                    
                    guard let dateStr =  strongSelf.dropOffViewModel.dropOffFirstDate() else {return }
                    strongSelf.selectedPickupDate = dateStr
                    
                    
                    guard let time =  strongSelf.dropOffViewModel.dropOffFirstTime() else {return }
                    strongSelf.selectedPickupTime = time
                    
                    
                    strongSelf.timeSelectionCollectionView.reloadData()
                    
                    
                }
                
            }else{
                showAlertMessage(vc: strongSelf, title: .Error, message: message)
            }
        }
        
        
        
    }

    func setupUI() {
//        self.specialInstructionTextView.textColor = TEXT_FIELD_COLOUR
//
//        self.firstButton.setTitleColor(UIColor.black, for: UIControlState.normal)
//        self.firstButton.backgroundColor = UIColor.white
//
//        self.secondButton.setTitleColor(UIColor.black, for: UIControlState.normal)
//        self.secondButton.backgroundColor = UIColor.white
//
//        self.schedulePickupButton.setTitleColor(COLOUR_ON_BUTTON, for: UIControlState.normal)
//        self.schedulePickupButton.backgroundColor = BUTTON_COLOUR
    }
    
    
    
}

extension DropOffVC{
    static func getStoryboardInstance() -> UINavigationController?{
        let storyborad = UIStoryboard(name: String(describing: self), bundle: nil)
        guard let navViewController = storyborad.instantiateInitialViewController()  as? UINavigationController else { return nil }
        return navViewController
    }
}




extension DropOffVC:UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 1 {
            
            if indexPath.row == 0 || indexPath.row == 1 {
                return // previos dates
            }
            
            guard let selDate = dropOffViewModel.dropOffDate(for: indexPath) else{ return }
            
            self.selectedDropOffDate = selDate
            
            self.selectedDateIndex = indexPath.item
            self.dateSelectionCollectionView.reloadData()
            self.timeSelectionCollectionView.reloadData()
            
        }else{
            
            
            guard let timeStr = dropOffViewModel.dropOffTime(for: indexPath, dropOffDate: self.selectedDropOffDate) else{return}
            self.selectedDropOffTime = timeStr
            self.timeSelectionCollectionView.reloadData()
        }
    }
    
    
}

extension DropOffVC:UICollectionViewDelegateFlowLayout{
    
    internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var cellSize:CGSize!
        
        if collectionView.tag == 1 {
            let width = (SCREEN_SIZE.width/5)
            cellSize = CGSize(width: width, height: 85)
        }else{
            let width = (SCREEN_SIZE.width/3)
            cellSize = CGSize(width: width, height: width/2)
            
        }
        
        return cellSize
    }
    
}

extension DropOffVC:UICollectionViewDataSource{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 1 {
            return dropOffViewModel.numberOfDropOffDate()
        }else{
            
            return dropOffViewModel.numberOfDropOffTime(dropOffDate: selectedDropOffDate)
            
        }
        
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if collectionView.tag == 1 {
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DateCollectionViewCell.identifier, for: indexPath) as? DateCollectionViewCell else { return UICollectionViewCell() }
            
            guard let dateStr =  dropOffViewModel.dropOffDate(for: indexPath) else {return UICollectionViewCell()  }
            if indexPath.row == 0 || indexPath.row == 1 {
                
                
                
                cell.contentView.backgroundColor = .lightGray
                cell.dayLabel.textColor = .gray
                cell.dateLabel.textColor = .gray
                cell.monthLabel.textColor = .gray
            }else{
                
                cell.contentView.backgroundColor = UIColor.white
                cell.dateLabel.textColor = BUTTON_COLOUR
                cell.dayLabel.textColor = UIColor.darkGray
                cell.monthLabel.textColor = UIColor.darkGray
            }
            
            let tempArr = dateStr.components(separatedBy: " ")
            cell.dayLabel.text = CommonUtilities.getWeekDayFromString(dateString: dateStr)
            cell.dateLabel.text = tempArr[0]
            cell.monthLabel.text = tempArr[1]
            
            if dateStr == self.selectedDropOffDate {
                cell.arrowImageView.isHidden = false
            }else{
                cell.arrowImageView.isHidden = true
            }
            return cell
        }else{
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TimeCollectionViewCell.identifier, for: indexPath) as? TimeCollectionViewCell else { return UICollectionViewCell() }
            
            
            guard let timeString = dropOffViewModel.dropOffTime(for: indexPath, dropOffDate: selectedDropOffDate) else{return UICollectionViewCell()}
            
            if timeString.contains("AM") {
                cell.timeLabel.text = timeString.replacingOccurrences(of: "AM", with: "")
                cell.formatLabel.text = "AM"
            }else{
                cell.timeLabel.text = timeString.replacingOccurrences(of: "PM", with: "")
                cell.formatLabel.text = "PM"
            }
            
            if timeString == self.selectedDropOffTime {
                cell.contentView.backgroundColor = BUTTON_COLOUR
                cell.timeLabel.textColor = UIColor.white
            }else{
                cell.contentView.backgroundColor = UIColor.white
                cell.timeLabel.textColor = BUTTON_COLOUR
            }
            return cell
        }
    }
    
    
}
