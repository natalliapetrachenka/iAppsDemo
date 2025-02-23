//
//  HorizontalGalleryDetailsViewModel.swift
//  iAppDemo
//
//  Created by Natallia Petrachenka on 23.02.25.
//

import SwiftUI

class HorizontalGalleryDetailsViewModel: ObservableObject {
    let item: HorizontalGalleryDetailsItem

    init(item: HorizontalGalleryDetailsItem) {
        self.item = item
    }
}
