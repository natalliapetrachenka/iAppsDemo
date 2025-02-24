//
//  HorizontalGalleryViewModel.swift
//  iAppDemo
//
//  Created by Natallia Petrachenka on 23.02.25.
//

import SwiftUI
import CoreApiClient

class HorizontalGalleryViewModel: ObservableObject {
    @Published var galleryTitle: String
    @Published var items: [GalleryDetailsItem]?

    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let apiClient: GalleryAPIClient
    private let category: String

    init(apiClient: GalleryAPIClient, category: String) {
        self.apiClient = apiClient
        self.category = category
        self.galleryTitle = category
    }

    func fetchGallery() async {
        await MainActor.run {
            isLoading = true
        }

        do {
            let gallery = try await apiClient.fetchGallery(for: category)

            await MainActor.run {
                self.items = gallery.items.map {
                    return GalleryDetailsItem(title: $0.title,
                                                        link: $0.link,
                                                        media: $0.media,
                                                        dateTaken: $0.dateTaken,
                                                        published: $0.published,
                                                        author: $0.author,
                                                        authorId: $0.authorId,
                                                        tags: $0.tags)
                }
                self.isLoading = false
            }
        } catch {
            print("Error \(error)")

            await MainActor.run {
                self.isLoading = false
                self.errorMessage = "Sorry. Something went wrong.."
            }
        }
    }
}
