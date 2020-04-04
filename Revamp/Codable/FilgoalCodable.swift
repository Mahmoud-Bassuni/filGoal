//
//  FilgoalCodable.swift
//  FilGoalIOS
//
//  Created by Bassuni on 12/19/19.
//  Copyright © 2019 Sarmady. All rights reserved.
//

import Foundation
struct LocationCodable: Codable {
    let country, code, region, city: String
    let latitude, longitude: Double
    let zipcode, timezone: String
}

struct SectionCodable: Codable {
    let sections: [Section]
    let types: [TypeElement]
    let champions: [Champion]
    
    enum CodingKeys: String, CodingKey {
        case sections = "Sections"
        case types = "Types"
        case champions = "Champions"
    }
}

// MARK: - Champion
struct Champion: Codable {
    let hasGroups: Bool
    let numRounds, displayorder, champType, champID: Int
    let sectionids: [Int]
    let sectionid: Int?
    let champLogo2, champLogo: String
    let champName: String
    
    enum CodingKeys: String, CodingKey {
        case hasGroups = "HasGroups"
        case numRounds = "NumRounds"
        case displayorder
        case champType = "champ_type"
        case champID = "champ_id"
        case sectionids, sectionid
        case champLogo2 = "champ_logo2"
        case champLogo = "champ_logo"
        case champName = "champ_name"
    }
}
// MARK: - Section
struct Section: Codable {
    let parentID, sectionID: Int
    let champIDS: [ChampID]
    let champID: Int
    let sectionName: String
    
    enum CodingKeys: String, CodingKey {
        case parentID = "parent_id"
        case sectionID = "section_id"
        case champIDS = "ChampIds"
        case champID = "ChampId"
        case sectionName = "section_name"
    }
}

// MARK: - ChampID
struct ChampID: Codable {
    let displayOrder, champID: Int
    
    enum CodingKeys: String, CodingKey {
        case displayOrder = "DisplayOrder"
        case champID = "ChampID"
    }
}

// MARK: - TypeElement
struct TypeElement: Codable {
    let typeID: Int
    let typeName: String
    
    enum CodingKeys: String, CodingKey {
        case typeID = "type_id"
        case typeName = "type_name"
    }
}

