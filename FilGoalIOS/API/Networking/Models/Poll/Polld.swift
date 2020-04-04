//
//  Poll.swift
//  FilGoalIOS
//
//  Created by Abdelrahman Elabd on 11/12/19.
//  Copyright © 2019 Sarmady. All rights reserved.
//

import UIKit

typealias JSONDictionary = [String:Any]

 class Polld : NSObject {
    
     @objc var pollID : NSString?
    
    override init() {
        
    }
    @objc convenience init(dic : NSDictionary) {
        self.init()
        print(dic)
        if let id = dic["Id"] as? Int {
            let idstr = NSString(format: "%d", id)
            self.pollID = idstr
        }
        
        
    }
    
}
