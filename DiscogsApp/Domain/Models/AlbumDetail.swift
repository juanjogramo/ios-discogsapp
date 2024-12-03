//
//  AlbumDetail.swift
//  DiscogsApp
//
//  Created by Juan José Granados Moreno on 3/12/24.
//

import Foundation

struct AlbumDetail: Codable {
    let title: String
    let id: Int
    let artists: [Artist]
    let thumb: String?
    let community: Community?
    let companies: [Company]?
    let country: String?
    let released: String?
    let genres: [String]?
    let styles: [String]?
    let tracklist: [Track]?
    let year: Int?

    struct Artist: Codable {
        let id: Int
        let name: String
        let resource_url: String
    }

    struct Community: Codable {
        let have: Int
        let want: Int
        let rating: Rating?
    }

    struct Rating: Codable {
        let average: Double
        let count: Int
    }

    struct Company: Codable {
        let name: String
        let resource_url: String
    }

    struct Track: Codable {
        let position: String
        let title: String
        let duration: String
    }
    
}
