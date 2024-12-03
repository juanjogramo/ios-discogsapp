//
//  ArtistDetailViewModel.swift
//  DiscogsApp
//
//  Created by Juan José Granados Moreno on 1/12/24.
//

import Foundation

@MainActor
class ArtistDetailViewModel: ObservableObject {
    @Published var artist: ArtistDetail?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let repository: ArtistRepositoryProtocol
    
    init(repository: ArtistRepositoryProtocol = ArtistRepository()) {
        self.repository = repository
    }
    
    var artistName: String {
        artist?.name ?? ""
    }

    func fetchArtistDetails(artistId: Int) async {
        isLoading = true
        errorMessage = nil

        do {
            artist = try await repository.fetchArtistDetails(artistId: artistId)
        } catch {
            errorMessage = "Failed to load artist details: \(error.localizedDescription)"
        }

        isLoading = false
    }
    
    func sortedMembers() -> [ArtistDetail.ArtistMember]? {
        guard let members = artist?.members else { return nil }
        return members.sorted { $0.active && !$1.active }
    }
    
}
