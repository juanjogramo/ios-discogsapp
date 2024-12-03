//
//  MemberReleasesViewModel.swift
//  DiscogsApp
//
//  Created by Juan José Granados Moreno on 3/12/24.
//

import SwiftUI

@MainActor
class MemberReleasesViewModel: ObservableObject {
    @Published var releases: [ArtistRelease] = []
    @Published var artistDetail: ArtistDetail?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let repository: ArtistRepositoryProtocol
    
    init(repository: ArtistRepositoryProtocol = ArtistRepository()) {
        self.repository = repository
    }
    
    func fetchReleases(for memberId: Int) async {
        isLoading = true
        errorMessage = nil

        do {
            releases = try await repository.fetchArtistReleases(artistId: memberId)
            artistDetail = try await repository.fetchArtistDetails(artistId: memberId)
        } catch {
            errorMessage = "Failed to load releases: \(error.localizedDescription)"
        }

        isLoading = false
    }
    
}
