//
//  NewsModelCodable.swift
//  FilGoalIOS
//
//  Created by Bassuni on 12/24/19.
//  Copyright © 2019 Sarmady. All rights reserved.
//
import Foundation
// MARK: - NewsModelCodable
struct NewsModelCodable: Codable {
    let news: [NewsCodable]
}
// MARK: - News
struct NewsCodable: Codable {
  
    let images: [ImageCodable]
    let newsTitle: String
    let id : Int
    enum CodingKeys: String, CodingKey {
        case images
        case newsTitle = "news_title"
        case id = "news_id"
    }
}
// MARK: - Image
struct ImageCodable: Codable {
    let caption: String
    let xlarge, large, small: String
}
// MARK: - NewsSectionID


