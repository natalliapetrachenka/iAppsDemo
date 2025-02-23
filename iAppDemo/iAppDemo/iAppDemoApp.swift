//
//  iAppDemoApp.swift
//  iAppDemo
//
//  Created by Natallia Petrachenka on 23.02.25.
//

import SwiftUI
import CoreApiClient

@main
struct iAppDemoApp: App {
    let apiClient = APIClient(environment: APIEnvironmentDev())

    var body: some Scene {
        WindowGroup {
            GalleryView(viewModel: GalleryViewModel(apiClient: apiClient))
        }
    }
}
