//
//  MockArtistRepository.swift
//  DiscogsApp
//
//  Created by Juan José Granados Moreno on 3/12/24.
//

import Foundation
@testable import DiscogsApp

final class MockArtistRepository: ArtistRepositoryProtocol {
    // MARK: - Properties to Simulate Results
    var fetchArtistsResult: Result<[ArtistResult], Error>?
    var fetchArtistDetailsResult: Result<ArtistDetail, Error>?
    var fetchArtistReleasesResult: Result<[ArtistRelease], Error>?
    var fetchAlbumDetailsResult: Result<AlbumDetail, Error>?
    
    // MARK: - Protocol Method Implementations

    func fetchArtists(query: String, page: Int) async throws -> [ArtistResult] {
        if let result = fetchArtistsResult {
            switch result {
            case .success(let artists):
                return artists
            case .failure(let error):
                throw error
            }
        }
        throw URLError(.badServerResponse)
    }

    func fetchArtistDetails(artistId: Int) async throws -> ArtistDetail {
        if let result = fetchArtistDetailsResult {
            switch result {
            case .success(let artistDetail):
                return artistDetail
            case .failure(let error):
                throw error
            }
        }
        throw URLError(.badServerResponse)
    }

    func fetchArtistReleases(artistId: Int) async throws -> [ArtistRelease] {
        if let result = fetchArtistReleasesResult {
            switch result {
            case .success(let releases):
                return releases
            case .failure(let error):
                throw error
            }
        }
        throw URLError(.badServerResponse)
    }

    func fetchAlbumDetails(albumId: Int) async throws -> AlbumDetail {
        if let result = fetchAlbumDetailsResult {
            switch result {
            case .success(let albumDetail):
                return albumDetail
            case .failure(let error):
                throw error
            }
        }
        throw URLError(.badServerResponse)
    }
}
