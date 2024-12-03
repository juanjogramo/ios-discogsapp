//
//  ArtistDetailView.swift
//  DiscogsApp
//
//  Created by Juan José Granados Moreno on 2/12/24.
//

import SwiftUI

struct ArtistDetailView: View {
    
    let artistId: Int
    @StateObject private var viewModel = ArtistDetailViewModel()
        
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                } else if let artist = viewModel.artist {
                    if let images = artist.images, !images.isEmpty {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(images, id: \.uri) { image in
                                    CachedAsyncImage(url: URL(string: image.uri))
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 200, height: 150)
                                        .clipped()
                                        .cornerRadius(8)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    if let members = viewModel.sortedMembers(), !members.isEmpty {
                        Text("Members")
                            .font(.headline)
                            .padding(.top)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(members) { member in
                                    NavigationLink(destination: BandMemberReleasesView(memberId: member.id)) {
                                        VStack {
                                            CachedAsyncImage(url: URL(string: member.thumbnailUrl ?? ""))
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 80, height: 80)
                                                .clipShape(Circle())
                                            Text(member.name)
                                                .font(.headline)
                                                .multilineTextAlignment(.center)
                                                .lineLimit(2)
                                                .frame(width: 100)
                                            
                                            Text(member.active ? "Active" : "Former Member")
                                                .font(.caption)
                                                .foregroundColor(member.active ? .green : .red)
                                        }
                                        .frame(width: 100)
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    NavigationLink(destination: AlbumsView(artistId: artistId)) {
                        Text("View Albums")
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding()
                            .background(Color.blue.opacity(0.2))
                            .cornerRadius(8)
                            .padding(.vertical)
                    }
                    if let profile = artist.profile {
                        Text("Profile")
                            .font(.headline)
                        Text(profile)
                            .font(.body)
                            .foregroundColor(.secondary)
                    }
                } else if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                }
            }
            .padding()
        }
        .navigationTitle(viewModel.artistName)
        .task {
            await viewModel.fetchArtistDetails(artistId: artistId)
        }
    }
    
}

#Preview {
    NavigationView {
        ArtistDetailView(artistId: 124535)
    }
}
