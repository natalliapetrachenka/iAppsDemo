//
//  ContentView.swift
//  iAppDemo
//
//  Created by Natallia Petrachenka on 23.02.25.
//

import SwiftUI
import CoreApiClient

struct GalleryView: View {
    @State private var selectedItem: HorizontalGalleryDetailsItem?
    let viewModel: GalleryViewModel

    var body: some View {
        List(viewModel.categories, id: \.self) { category in
            let horizontalGalleryVM1 = HorizontalGalleryViewModel(apiClient: viewModel.apiClient,
                                                                  category: category)
            HorizontalGalleryView(viewModel: horizontalGalleryVM1,
                                  selectedItem: $selectedItem)
            .frame(height: 180)
        }
        .listStyle(.plain)
        .fullScreenCover(item: $selectedItem) { item in
            let horizontalGalleryDetailsVM = HorizontalGalleryDetailsViewModel(item: item)
            HorizontalGalleryDetailsView(viewModel: horizontalGalleryDetailsVM)
        }
    }
}

#Preview {
    let viewModel = GalleryViewModel(apiClient: APIClient(environment: APIEnvironmentDev()))
    GalleryView(viewModel: viewModel)
}
