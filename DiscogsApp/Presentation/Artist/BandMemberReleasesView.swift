//
//  BandMemberReleasesView.swift
//  DiscogsApp
//
//  Created by Juan José Granados Moreno on 3/12/24.
//

import SwiftUI

struct BandMemberReleasesView: View {
    let memberId: Int
    @StateObject private var viewModel = MemberReleasesViewModel()

    var name: String {
        viewModel.artistDetail?.name ?? "Member Details"
    }
    
    var body: some View {
        List {
            if viewModel.isLoading {
                ProgressView("Loading...")
            } else {
                if let detail = viewModel.artistDetail, let profile = detail.profile {
                    Section {
                        Text("Profile")
                            .font(.headline)
                        Text(profile)
                            .font(.body)
                            .foregroundColor(.secondary)
                    }
                }
                Text("Releases")
                    .font(.headline)
                ForEach(viewModel.releases) { release in
                    HStack {
                        CachedAsyncImage(url: URL(string: release.thumb))
                            .frame(width: 50, height: 50)
                            .cornerRadius(8)

                        VStack(alignment: .leading) {
                            Text(release.title)
                                .font(.headline)
                            if let year = release.year {
                                Text("Released: \(year)")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
            }
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            }
        }
        .navigationTitle(name)
        .task {
            await viewModel.fetchReleases(for: memberId)
        }
    }
}

#Preview {
    NavigationView {
        BandMemberReleasesView(memberId: 1233)
    }
}
