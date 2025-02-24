//
//  GalleryDetailsBottomBar.swift
//  iAppDemo
//
//  Created by Natallia Petrachenka on 24.02.25.
//

import SwiftUI

struct GalleryDetailsBottomBar: View {
    let spacerHeight: CGFloat
    let homeTapAction: (() -> ())?
    let audioTapAction: (() -> ())?

    private let topPadding: CGFloat = 10
    private let horizontalPadding: CGFloat = 20

    var body: some View {
        VStack(spacing: 0) {
            Spacer()
                .frame(maxWidth: .infinity)
                .frame(height: spacerHeight)
                .background(.black)

            HStack {
                Button {
                    homeTapAction?()
                } label: {
                    Text("Home")
                        .foregroundColor(.black)
                }

                Spacer()
                    .frame(width: 10)

                Button {
                    audioTapAction?()
                } label: {
                    Text("Audio")
                        .foregroundColor(.black)
                }

                Spacer()

            }
            .padding(EdgeInsets(top: topPadding,
                                leading: horizontalPadding,
                                bottom: 0,
                                trailing: horizontalPadding))
            .frame(maxWidth: .infinity)

            Spacer()
        }
    }
}

