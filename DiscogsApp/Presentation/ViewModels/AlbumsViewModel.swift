//
//  AlbumsViewModel.swift
//  DiscogsApp
//
//  Created by Juan José Granados Moreno on 2/12/24.
//

import SwiftUI

@MainActor
class AlbumsViewModel: ObservableObject {
    
    @Published var albums: [ArtistRelease] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let repository: ArtistRepositoryProtocol
    
    init(repository: ArtistRepositoryProtocol = ArtistRepository()) {
        self.repository = repository
    }
    
    var availableYears: [String] {
        Set(albums.compactMap { $0.year }.map { String($0) }).sorted(by: >)
    }
    
    var availableLabels: [String] {
        Set(albums.compactMap { $0.label }).sorted()
    }
    
    func fetchAlbums(for artistId: Int) async {
        isLoading = true
        errorMessage = nil
        do {
            let fetchedAlbums = try await repository.fetchArtistReleases(artistId: artistId)
            albums = fetchedAlbums.sorted(by: { $0.year ?? 0 > $1.year ?? 0 })
        } catch {
            errorMessage = "Failed to load albums: \(error.localizedDescription)"
        }
        isLoading = false
    }
    
    func filteredAlbums(year: String?, label: String?) -> [ArtistRelease] {
        albums.filter { album in
            var matches = true
            if let year = year {
                matches = matches && album.year == Int(year)
            }
            if let label = label {
                matches = matches && (album.label?.contains(label) ?? false)
            }
            return matches
        }
    }
    
}
