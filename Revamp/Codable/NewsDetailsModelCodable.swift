//
//  NewsDetailsModelCodable.swift
//  FilGoalIOS
//
//  Created by Bassuni on 12/31/19.
//  Copyright © 2019 Sarmady. All rights reserved.
//

import Foundation

// MARK: - NewsDetailsModelCodable
struct NewsDetailsModelCodable: Codable {
    let isRedirect: Bool!
    let newsID: Int!
    let newsSectionID: [SectionID]!
    let relatedNews: [RelatedNew]!
    let relatedVideos: [RelatedVideo]!
    let relatedAlbums: [JSONAny]!
    let images: [Image]!
    let quotes, authorRelatedOpinions: [JSONAny]!
    let authors: [AuthorCodable]!
    let relatedData: RelatedData!
    let commentsNo, newsTypeID: Int!
    let redirectURL, status, sourceDate, newsDate: String!
    var newsTitle, newsDescription: String

    enum CodingKeys: String, CodingKey {
        case isRedirect = "IsRedirect"
      
        case newsID = "news_id"
     
        case newsSectionID = "news_section_id"
        case relatedNews = "related_news"
        case relatedVideos = "related_videos"
        case relatedAlbums = "related_albums"
        case images, quotes, authorRelatedOpinions, authors
        case relatedData = "related_data"
        case commentsNo = "comments_no"
        case newsTypeID = "news_type_id"
        case redirectURL = "RedirectUrl"
        case status
        case sourceDate = "source_date"
        case newsDate = "news_date"
        case newsTitle = "news_title"
        case newsDescription = "news_description"
    }
}

// MARK: - Author
struct AuthorCodable: Codable {
    let id: Int!
    let image: String!
    let name: String!

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case image = "Image"
        case name = "Name"
    }
}

// MARK: - Image
struct Image: Codable {
    let caption: String!
    let xlarge, large, small: String!
}

// MARK: - SectionID
struct SectionID: Codable {
    let sectionID: Int!

    enum CodingKeys: String, CodingKey {
        case sectionID = "section_id"
    }
}

// MARK: - RelatedData
struct RelatedData: Codable {
    let championships: [Championship]!
    let matches: [Match]!
    let teams, people: [JSONAny]!

    enum CodingKeys: String, CodingKey {
        case championships = "Championships"
        case matches = "Matches"
        case teams = "Teams"
        case people = "People"
    }
}

// MARK: - Championship
struct Championship: Codable {
    let id: Int!
    let name: String!
}

// MARK: - Match
struct Match: Codable {
    let championshipID, awayTeamID, homeTeamID, id: Int!
    let awayPenaltyScore, awayScore, homePenaltyScore, homeScore: Int!
    let date, championshipName, awayTeamName, homeTeamName: String!

    enum CodingKeys: String, CodingKey {
        case championshipID = "championshipId"
        case awayTeamID = "awayTeamId"
        case homeTeamID = "homeTeamId"
        case id, awayPenaltyScore, awayScore, homePenaltyScore, homeScore, date, championshipName, awayTeamName, homeTeamName
    }
}

// MARK: - RelatedNew
struct RelatedNew: Codable {
    let newsTypeID, newsID: Int!
    let newsSectionID: [SectionID]!
    let images: [Image]!
    let type: String!
    let newsDescription: String!
    let newsWriter, newsDate: String!
    let smallImage: String!
    let newsTitle: String!

    enum CodingKeys: String, CodingKey {
        case newsTypeID = "news_type_id"
        case newsID = "news_id"
        case newsSectionID = "news_section_id"
        case images, type
        case newsDescription = "news_description"
        case newsWriter = "news_writer"
        case newsDate = "news_date"
        case smallImage = "small_Image"
        case newsTitle = "news_title"
    }
}

// MARK: - RelatedVideo
struct RelatedVideo: Codable {
    let videoNumofviews, videoID: Int!
    let videoSectionID: [SectionID]!
    let videoURL, videoDetails, sourceDate, videoDate: String!
    let videoPreviewImage: String!
    let videoTitle: String!

    enum CodingKeys: String, CodingKey {
        case videoNumofviews = "video_numofviews"
        case videoID = "video_id"
        case videoSectionID = "video_section_id"
        case videoURL = "video_url"
        case videoDetails = "video_details"
        case sourceDate = "source_date"
        case videoDate = "video_date"
        case videoPreviewImage = "video_preview_image"
        case videoTitle = "video_title"
    }
}
