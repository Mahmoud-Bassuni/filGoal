//
//  testVM.swift
//  FilGoalIOS
//
//  Created by Bassuni on 12/17/19.
//  Copyright © 2019 Sarmady. All rights reserved.
//

import Foundation
@objc public class FilgoalVM : NSObject {
    @objc func getData(){
        let serviceAdapter =  NetworkAdapter<FilgoalEnum>()
        serviceAdapter.request(target: .getTimeZone, success: { [unowned self] (response:LocationCodable)   in
            let timeZone = response
            print(timeZone)
            }, error: { error in print(error) }
            , failure: {_ in })
    }
    @objc func getSection(){
        let serviceAdapter =  NetworkAdapter<FilgoalEnum>()
        serviceAdapter.request(target: .getMetadata(countryId : "0"), success: { [unowned self] (response:SectionCodable)   in
            let metadata = response
            print(metadata)
            }, error: { error in print(error) }
            , failure: {_ in })
    }
}

