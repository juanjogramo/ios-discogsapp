//
//  ArtistRepository.swift
//  DiscogsApp
//
//  Created by Juan José Granados Moreno on 2/12/24.
//

import Foundation

protocol ArtistRepositoryProtocol: AnyObject {
    
    func fetchArtists(query: String, page: Int) async throws -> [ArtistResult]
    func fetchArtistDetails(artistId: Int) async throws -> ArtistDetail
    func fetchArtistReleases(artistId: Int) async throws -> [ArtistRelease]
    func fetchAlbumDetails(albumId: Int) async throws -> AlbumDetail
    
}

final class ArtistRepository: ArtistRepositoryProtocol {
    
    private let apiService: Service

    init(apiService: Service = APIService()) {
        self.apiService = apiService
    }

    /// Fetch a paginated list of artists based on a search query.
    /// - Parameters:
    ///   - query: The search query.
    ///   - page: The page number to fetch.
    /// - Returns: A tuple containing the `ArtistsResponse` and the associated `Pagination` metadata.
    func fetchArtists(query: String, page: Int) async throws -> [ArtistResult] {
        let queryParams = [
            "q": query,
            "type": "artist",
            "per_page": "3",
            "page": "\(page)"
        ]
        
        let response: ArtistsResponse = try await apiService.request(
            endpoint: "/database/search",
            queryParameters: queryParams,
            responseType: ArtistsResponse.self
        )
        
        return response.results
    }

    /// Fetch detailed information about a specific artist.
    /// - Parameter artistId: The ID of the artist to fetch.
    /// - Returns: An `ArtistDetail` object containing detailed artist information.
    func fetchArtistDetails(artistId: Int) async throws -> ArtistDetail {
        try await apiService.request(
            endpoint: "/artists/\(artistId)",
            queryParameters: nil,
            responseType: ArtistDetail.self
        )
    }

    /// Fetch a list of albums or releases for a specific artist.
    /// - Parameter artistId: The ID of the artist whose releases to fetch.
    /// - Returns: A list of `Album` objects sorted by release date.
    func fetchArtistReleases(artistId: Int) async throws -> [ArtistRelease] {
        let response: ArtistReleasesResponse = try await apiService.request(
            endpoint: "/artists/\(artistId)/releases",
            queryParameters: [
                "sort": "year",
                "sort_order": "asc",
                "per_page": "10"
            ],
            responseType: ArtistReleasesResponse.self
        )
        return response.releases
    }
    
    func fetchAlbumDetails(albumId: Int) async throws -> AlbumDetail {
        return try await apiService.request(
            endpoint: "/releases/\(albumId)",
            queryParameters: nil,
            responseType: AlbumDetail.self
        )
    }
    
}
