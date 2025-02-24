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
    @Binding var selectedItem: GalleryDetailsItem?

    private let horizontalGalleryCellSize = CGSize(width: 120, height: 140)
    private let horizontalGalleryCellSpacing: CGFloat = 8
    private let titleTopPadding: CGFloat = 10
    private let titleBottomPadding: CGFloat = 4
    private let titleHorizontalPadding: CGFloat = 8

    init(viewModel: HorizontalGalleryViewModel,
         selectedItem: Binding<GalleryDetailsItem?>) {
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
                        Text(viewModel.galleryTitle)
                            .font(.title3)
                            .bold()
                            .foregroundColor(.black)
                            .padding(EdgeInsets(top: titleTopPadding,
                                                leading: titleHorizontalPadding,
                                                bottom: titleBottomPadding,
                                                trailing: titleHorizontalPadding))

                        ScrollView(.horizontal) {
                            LazyHStack(spacing: horizontalGalleryCellSpacing) {
                                ForEach(items, id: \.self) { item in
                                    HorizontalGalleryCell(item: item.horizontalGalleryCellItem) {
                                        selectedItem = item
                                    }
                                    .frame(width: horizontalGalleryCellSize.width,
                                           height: horizontalGalleryCellSize.height)
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
    @Previewable @State var selectedItem: GalleryDetailsItem?
    let viewModel = HorizontalGalleryViewModel(apiClient: APIClient(environment: APIEnvironmentDev()),
                                               category: "Paris")
    HorizontalGalleryView(viewModel: viewModel,
                          selectedItem: $selectedItem)
}
