//
//  Constants.swift
//  hermesos
//
//  Created by Uzziah on 2018-08-07.
//  Copyright © 2018 eyeezzi. All rights reserved.
//

struct Endpoints {
    static let BASE = "http://localhost:3000/api"
    
    static let SIGNUP_REQUEST_SMS = "/auth/sign_up/request_sms" // POST
    static let SIGNUP_VERIFY_CODE = "/auth/sign_up/verify_code" // POST
    
    static let SIGNIN_REQUEST_SMS = "/auth/sign_in/request_sms" // POST
    static let SIGNIN_VERIFY_CODE = "/auth/sign_in/verify_code" // POST
    
    static let DELETE_ACCOUNT = "/auth/delete_account" // POST

    // GET: list all SOS for user
    // POST: schedule an SOS
    // DELETE: /id to delete a scheduled SOS
    static let SOS = "/sos"
    
    // GET: /id for user profile
    static let USER = "/users"
}
