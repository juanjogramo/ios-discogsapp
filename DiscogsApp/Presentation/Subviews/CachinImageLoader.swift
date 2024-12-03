//
//  CachinImageLoader.swift
//  DiscogsApp
//
//  Created by Juan José Granados Moreno on 2/12/24.
//

import SwiftUI
import Combine

class CachingImageLoader: ObservableObject {
    
    @Published var image: UIImage?
    private var cache = URLCache.shared
    
    func loadImage(from url: URL) async {
        if let cachedResponse = cache.cachedResponse(for: URLRequest(url: url)),
           let cachedImage = UIImage(data: cachedResponse.data) {
            await MainActor.run {
                self.image = cachedImage
            }
            return
        }
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                return
            }
            let cachedResponse = CachedURLResponse(response: response, data: data)
            cache.storeCachedResponse(cachedResponse, for: URLRequest(url: url))
            if let downloadedImage = UIImage(data: data) {
                await MainActor.run {
                    self.image = downloadedImage
                }
            }
        } catch {
            print("Failed to load image from \(url): \(error)")
        }
    }
    
}
