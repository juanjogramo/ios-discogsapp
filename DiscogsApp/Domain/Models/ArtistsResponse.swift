//
//  ArtistsResponse.swift
//  DiscogsApp
//
//  Created by Juan José Granados Moreno on 1/12/24.
//

import Foundation

struct ArtistsResponse: Codable {
    let pagination: Pagination
    let results: [ArtistResult]
}

struct Pagination: Codable {
    let page: Int
    let pages: Int
    let perPage: Int
    let items: Int
    let urls: PaginationUrls?

    enum CodingKeys: String, CodingKey {
        case page, pages, items, urls
        case perPage = "per_page"
    }
}

struct PaginationUrls: Codable {
    let last: String?
    let next: String?
}

struct ArtistResult: Codable, Identifiable {
    let id: Int
    let type: String
    let userData: UserData?
    let masterId: Int?
    let masterUrl: String?
    let uri: String
    let title: String
    let thumb: String
    let coverImage: String
    let resourceUrl: String
    let country: String?
    let year: String?
    let format: [String]?
    let label: [String]?
    let genre: [String]?
    let style: [String]?
    let barcode: [String]?
    let community: CommunityData?

    enum CodingKeys: String, CodingKey {
        case id, type, uri, title, thumb, country, year, format, label, genre, style, barcode, community
        case userData = "user_data"
        case masterId = "master_id"
        case masterUrl = "master_url"
        case coverImage = "cover_image"
        case resourceUrl = "resource_url"
    }
}

struct UserData: Codable {
    let inWantlist: Bool
    let inCollection: Bool

    enum CodingKeys: String, CodingKey {
        case inWantlist = "in_wantlist"
        case inCollection = "in_collection"
    }
}

struct CommunityData: Codable {
    let want: Int
    let have: Int
}
