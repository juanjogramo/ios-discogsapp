//
//  AlbumDetailViewModel.swift
//  DiscogsApp
//
//  Created by Juan José Granados Moreno on 3/12/24.
//

import SwiftUI

@MainActor
class AlbumDetailViewModel: ObservableObject {
    
    @Published var album: AlbumDetail?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let repository: ArtistRepositoryProtocol
    
    init(repository: ArtistRepositoryProtocol = ArtistRepository()) {
        self.repository = repository
    }

    func fetchAlbumDetails(albumId: Int) async {
        isLoading = true
        errorMessage = nil

        do {
            album = try await repository.fetchAlbumDetails(albumId: albumId)
        } catch {
            errorMessage = "Failed to load album details: \(error.localizedDescription)"
        }

        isLoading = false
    }
}
