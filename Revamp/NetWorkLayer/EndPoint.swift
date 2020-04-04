//
//  EndPoint.swift
//  FilGoalIOS
//
//  Created by Bassuni on 12/19/19.
//  Copyright © 2019 Sarmady. All rights reserved.
//
import Foundation
enum EndPoint: String{
    case baseUrl = "https://api.filgoal.com/"
    case locationBaseUrl = "https://ip2location.sarmady.net/"
}
enum ServiceEndPoint: String{
    case locationURL = "api/GeoIP?&client=C1DA4262-4AD1-4399-A039-5184897BCA13"
    case metadata = "news/metadata"
    case newsSection = "news/NewsSection"
    case newsDetails = "news/details"
}
