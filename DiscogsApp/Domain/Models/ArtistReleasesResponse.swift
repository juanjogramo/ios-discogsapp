//
//  ArtistReleasesResponse.swift
//  DiscogsApp
//
//  Created by Juan José Granados Moreno on 2/12/24.
//

struct ArtistReleasesResponse: Codable {
    let pagination: Pagination
    let releases: [ArtistRelease]
}

struct ArtistRelease: Codable, Identifiable {
    let id: Int
    let artist: String
    let mainRelease: Int?
    let resourceUrl: String
    let role: String
    let thumb: String
    let title: String
    let type: String
    let year: Int?
    let format: String?
    let label: String?
    let status: String?

    enum CodingKeys: String, CodingKey {
        case id, artist, role, thumb, title, type, year, format, label, status
        case mainRelease = "main_release"
        case resourceUrl = "resource_url"
    }
}
