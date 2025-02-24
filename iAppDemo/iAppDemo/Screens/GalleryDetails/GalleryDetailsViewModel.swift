//
//  GalleryDetailsViewModel.swift
//  iAppDemo
//
//  Created by Natallia Petrachenka on 23.02.25.
//

import SwiftUI

class GalleryDetailsViewModel: ObservableObject {
    private static let audioTitle: String = "An audio title"
    private static let audioDescription: String = "Leroy ipsum dolor sit amet, consectetur adipiscing elit. Suspendensse vulputate ac dolor sed vehicula. Nam risus purus, sodalis non ullamcorper sed, commodo in metus. Donec non ornare magna. Nulla vel ipsum ac justo"

    let item: GalleryDetailsItem
    let audioDetails: AudioDetails = {
        return AudioDetails(title: audioTitle, description: audioDescription)
    }()

    init(item: GalleryDetailsItem) {
        self.item = item
    }
}
