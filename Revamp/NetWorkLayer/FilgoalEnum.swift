//
//  FilgoalEnum.swift
//  FilGoalIOS
//
//  Created by Bassuni on 12/19/19.
//  Copyright © 2019 Sarmady. All rights reserved.
//
import Foundation
import Moya

enum FilgoalEnum{
    case getTimeZone
    case getMetadata(countryId : String)
}
extension FilgoalEnum: TargetType{
    var sampleData: Foundation.Data { // for unit test
        return Data()
    }
    var baseURL: URL {
        switch self{
        case .getTimeZone:
            return URL(string: EndPoint.locationBaseUrl.rawValue)! // without token
        case .getMetadata:
            return URL(string: EndPoint.baseUrl.rawValue)! // with hmac token
        }
    }
    var path: String {
        switch self{
        case .getTimeZone: return ServiceEndPoint.locationURL.rawValue
        case .getMetadata: return ServiceEndPoint.metadata.rawValue
        }
    }
    var method: Moya.Method {
        switch self {
        case .getTimeZone , .getMetadata:  return .get
        }
    }
    var task: Task {
        switch self {
        case .getTimeZone:
            return .requestPlain
        case let .getMetadata(countryId):
            return .requestParameters(parameters: ["countryId":countryId], encoding: URLEncoding.queryString)
        }
    }
    var headers: [String : String]?{
        
        let metadataHMAC = WServicesManager().getHMACHeaderString("https://api.filgoal.com/news/metadata?countryId=0",andParameters: nil, andTimestamp: "")!
        switch self {
        case .getTimeZone:
            return ["Content-Type" : "application/json" ]
        case .getMetadata:
            return ["api-version" : "2","Authorization" : metadataHMAC]
        }
    }
}
