//
//  WebServiceConstant.swift
//  QDCCustomerApp
//
//  Created by shashank sharma on 18/08/16.
//  Copyright © 2016 QuickDryCleaning. All rights reserved.
//

import Foundation

let isForcePinCodeEnabled = true
let PINCODE = "110018"//"123456"//"133301"
let APPSLUG = "Perfect"//"qdctesting"//"drygreen"
//For testing
//"qdctesting/"
let QDC_BASE_URL                         = "http://quickdrycleaningclients.com:9002/api/testing/"
//"http://quickdrycleaningclients.com:9002/api/7.0/"
//for testing
//"http://quickdrycleaningclients.com:9002/api/testing/"
let QDC_NOTIFICATION_BASE_URL            = "http://quickdrycleaningclients.com:9002/api/7.0/drygreen/"
let GET_LICENSE_DETAIL_RELATIVE_URL      = "LicenseDetails/"
let INSERT_PINCODE_RELATIVE_URL          = "InsertPincode"
let GET_CUSTOMER_TOKEN_RELATIVE_URL      = "GetCustomerToken"
let GET_CUSTOMER_DETAIL_RELATIVE_URL     = "CheckExistingCustomer?"
let REGISTER_NEW_CUSTOMER_RELATIVE_URL   = "CustomerCreation"
let CHECK_CUSTOMER_OTP_RELATIVE_URL      = "OTPCheck/"
let RESEND_OTP_RELATIVE_URL              = "ReSendOTP"
let CUSTOMER_HOME_RELATIVE_URL           = "CustomerSummary/"
let REQUEST_PICKUP_RELATIVE_URL          = "SchedulePickup"
let REQUEST_DROPOFF_RELATIVE_URL         = "ScheduleDropOff"
let MY_REQUESTS_RELATIVE_URL             = "MyRequset/"
let CUSTOMER_DROPOFFS_RELATIVE_URL       = "CustomerDropOffRequest/"
let PICKUP_DATE_RELATIVE_URL             = "PickUpDate/"
let SCHEDULE_DETAILS_RELATIVE_URL        = "ScheduleDetails/"
let DROPOFF_DATE_AND_TIME_RELATIVE_URL   = "DropOffDateAndTime?"
let MY_ORDERS_RELATIVE_URL               = "MyOrders/"
let GET_OFFERS_RELATIVE_URL              = "offers/"
let ORDER_DETAILS_RELATIVE_URL           = "OrderDetails/"
let PRICE_LIST_RELATIVE_URL              = "Pricelist/"
let UPDATE_CUSTOMER_PROFILE_RELATIVE_URL = "UpdateCustomer"
let FEEDBACK_RELATIVE_URL                = "Feedback"
let ABOUT_US_RELATIVE_URL                = "StoreAboutUsDetails/"
let GET_STORE_DETAIL_RELATIVE_URL        = "Store/"
let UPDATE_GCM_KEY_RELATIVE_URL          = "UpdateGCM"
let NOTIFICATION_RELATIVE_URL            = "PushNotification/"

let PENDING_GARMENTS_RELATIVE_URL        = "PendingGarment/DryCleanKart/1/cust2"
let PENDING_AMOUNT_RELATIVE_URL          = "PendingAmount/DryCleanKart/1/cust2"
let PAY_NOW_RELATIVE_URL                 = ""
let GET_CANCEL_REASON_RELATIVE_URL       = "CancelReason/"
let SHARE_MECHANISM_RELATIVE_URL         = ""
let GET_LICENSE_RELATIVE_URL             = "License/DryCleanKart/2/1223.26"

let PAYMENT_UPDATE                      = "PaymentResponse"
//enum




let kWebServicePostParamKey =  "postParamKey"
let kWebServiceUrlParamKey = "urlParamKey"

//DROPOFF DATE AND TIME
let PICKUP_DATE_REQUEST_KEY = "pickupDateKey"
let PICKUP_TIME_REQUEST_KEY = "pickupTimeKey"
