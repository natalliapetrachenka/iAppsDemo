//
//  HorizontalGalleryView.swift
//  iAppDemo
//
//  Created by Natallia Petrachenka on 23.02.25.
//

import SwiftUI
import CoreApiClient

struct HorizontalGalleryView: View {
    @ObservedObject private var viewModel: HorizontalGalleryViewModel
    @Binding var selectedItem: HorizontalGalleryDetailsItem?

    init(viewModel: HorizontalGalleryViewModel,
         selectedItem: Binding<HorizontalGalleryDetailsItem?>) {
        self.viewModel = viewModel
        _selectedItem = selectedItem
    }

    var body: some View {
        VStack(spacing: 0) {
            if viewModel.isLoading {
                ProgressView("Loading...")
                    .frame(maxWidth: .infinity)
                    .padding()
            } else if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .frame(maxWidth: .infinity)
                    .padding()
            } else {
                if let items = viewModel.items {
                    VStack(alignment: .leading, spacing: 0) {
                        Spacer()
                            .frame(height: 10)

                        Text(viewModel.galleryTitle)
                            .font(.title3)
                            .bold()
                            .foregroundColor(.black)
                            .offset(x: 20)

                        Spacer()
                            .frame(height: 4)

                        ScrollView(.horizontal) {
                            LazyHStack(spacing: 8) {
                                ForEach(items, id: \.self) { item in
                                    HorizontalGalleryCell(item: item.horizontalGalleryCellItem) {
                                        selectedItem = item
                                    }
                                    .frame(width: 120, height: 140)
                                }
                            }
                            .padding()
                        }
                        .clipped()
                    }
                }
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchGallery()
            }
        }
    }

}

#Preview {
    @Previewable @State var selectedItem: HorizontalGalleryDetailsItem?
    let viewModel = HorizontalGalleryViewModel(apiClient: APIClient(environment: APIEnvironmentDev()),
                                               category: "Paris")
    HorizontalGalleryView(viewModel: viewModel,
                          selectedItem: $selectedItem)
}
