//
//  View+Extensions.swift
//  iAppDemo
//
//  Created by Natallia Petrachenka on 24.02.25.
//

import SwiftUI

extension View {

    @ViewBuilder
    func offsetExtractor(coordinateSpace: String, completion: @escaping (CGRect) -> ()) -> some View {
        self
            .overlay {
                GeometryReader {
                    let rect = $0.frame(in: .named(coordinateSpace))
                    Color.clear
                        .preference(key: OffsetKey.self, value: rect)
                        .onPreferenceChange(OffsetKey.self, perform: completion)
                }
            }
    }

}

