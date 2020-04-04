//
//  NewsService.swift
//  FilGoalIOS
//
//  Created by Bassuni on 12/24/19.
//  Copyright © 2019 Sarmady. All rights reserved.
//
import Foundation
import Moya
enum NewsServiceEnum{
    case getNewsSection(pageSize: String,catId: String,langId: String,sectionId: String,pageNumber: String)
    case getNewsDetails(id: String)
}
extension NewsServiceEnum: TargetType{
    var sampleData: Foundation.Data { // for unit test
        return Data()
    }
    var baseURL: URL {
        switch self{
        case .getNewsSection ,.getNewsDetails: return URL(string: EndPoint.baseUrl.rawValue)!
        }
    }
    var path: String {
        switch self{
        case .getNewsSection: return ServiceEndPoint.newsSection.rawValue
        case .getNewsDetails: return ServiceEndPoint.newsDetails.rawValue
        }
    }
    var method: Moya.Method {
        switch self {
        case .getNewsSection ,.getNewsDetails : return .get
        }
    }
    var task: Task {
        switch self {
        case let .getNewsSection(pageSize,catId,langId,sectionId,pageNumber):
            return .requestParameters(parameters: ["PageSize":pageSize,"CatId":catId,"langId":langId,"SectionId":sectionId,"PageNumber":pageNumber], encoding: URLEncoding.queryString)
        case let .getNewsDetails(id):
            return .requestParameters(parameters: ["id":id], encoding: URLEncoding.queryString)
        }
    }
    var headers: [String : String]?{
        switch self {
         case let .getNewsSection(pageSize,catId,langId,sectionId,pageNumber):
             let tokenHMAC = WServicesManager().getHMACHeaderString("\(EndPoint.baseUrl.rawValue)\(ServiceEndPoint.newsSection.rawValue)?CatId=\(catId)&PageNumber=\(pageNumber)&PageSize=\(pageSize)&SectionId=\(sectionId)&langId=\(langId)",andParameters: nil, andTimestamp: "")!
            return ["api-version" : "2","Authorization" : tokenHMAC]
         case let .getNewsDetails(id):
            let tokenHMAC = WServicesManager().getHMACHeaderString("\(EndPoint.baseUrl.rawValue)\(ServiceEndPoint.newsDetails.rawValue)?id=\(id)",andParameters: nil, andTimestamp: "")!
            return ["api-version" : "2","Authorization" : tokenHMAC]
        }
    }
}
