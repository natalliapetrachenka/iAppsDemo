//
//  AsyncImageLoader.swift
//  iAppDemo
//
//  Created by Natallia Petrachenka on 23.02.25.
//

import SwiftUI
//import Combine

@MainActor
public class AsyncImageLoader: ObservableObject {
    @Published public var image: Image?

    private let compressedImageSize: CGSize?
    private let url: URL
    private var task: Task<Void, Never>?

    public init(url: URL, compressedImageSize: CGSize? = nil) {
        self.url = url
        self.compressedImageSize = compressedImageSize
        loadImage()
    }
}

extension AsyncImageLoader {
    func cancel() {
        task?.cancel()
    }


    private func loadImage() {
        task?.cancel()

        task = Task {
            if let cachedImage = ImageCache.shared.getImage(for: url, compressedImageSize: compressedImageSize) {
                self.image = cachedImage
                return
            }

            do {
                let (data, response) = try await URLSession.shared.data(from: url)

                let httpURLResponse = response as? HTTPURLResponse
                guard let httpURLResponse = httpURLResponse, (200...299).contains(httpURLResponse.statusCode) else {
                    print("Failed to download image status code: \(httpURLResponse?.statusCode ?? 0)")
                    return
                }

                guard let downloadedImage = UIImage(data: data) else { return }
                if let compressedImageSize = compressedImageSize,
                   let compressedImage = downloadedImage.preparingThumbnail(of: compressedImageSize) {
                    ImageCache.shared.setUIImage(compressedImage, for: url, compressedImageSize: compressedImageSize)
                }

                self.image = Image(uiImage: downloadedImage)
                ImageCache.shared.setUIImage(downloadedImage, for: url.absoluteString)
            } catch {
                print("Failed to download image: \(error.localizedDescription)")
            }
        }
    }
}
