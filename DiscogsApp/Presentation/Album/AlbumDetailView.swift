//
//  AlbumDetailView.swift
//  DiscogsApp
//
//  Created by Juan José Granados Moreno on 3/12/24.
//

import SwiftUI

struct AlbumDetailView: View {
    
    let albumId: Int
    @StateObject private var viewModel = AlbumDetailViewModel()

    var title: String {
        viewModel.album?.title ?? "Album Details"
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                } else if let album = viewModel.album {
                    CachedAsyncImage(url: URL(string: album.thumb ?? ""))
                        .frame(height: 200)
                        .cornerRadius(12)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        if let year = album.year {
                            Text("Release Year: \(year)")
                        }
                        if let genre = album.genres?.joined(separator: ", ") {
                            Text("Genre: \(genre)")
                        }
                    }
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    if let tracklist = album.tracklist {
                        Text("Tracklist")
                            .font(.headline)
                            .padding(.top)
                        ForEach(tracklist, id: \.position) { track in
                            HStack {
                                Text("\(track.position). \(track.title)")
                                    .font(.body)
                                Spacer()
                                Text(track.duration)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            .padding(.vertical, 4)
                        }
                    }
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                }
            }
            .padding()
        }
        .navigationTitle(title)
        .task {
            await viewModel.fetchAlbumDetails(albumId: albumId)
        }
    }
}

#Preview {
    NavigationView {
        AlbumDetailView(albumId: 12345)
    }
}
