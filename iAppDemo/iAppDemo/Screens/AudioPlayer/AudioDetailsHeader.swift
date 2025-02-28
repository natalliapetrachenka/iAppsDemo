//
//  AudioDetailsHeader.swift
//  iAppDemo
//
//  Created by Natallia Petrachenka on 28.02.25.
//

import SwiftUI

struct AudioDetailsHeader: View {
    var closeTapAction: (() -> ())?

    private let capsuleSize = CGSizeMake(80.0, 4.0)
    private let capsuleTopPadding: CGFloat = 10.0

    private let closeButtonSize = CGSizeMake(36.0, 36.0)
    private let closeButtonTopPadding: CGFloat = 10.0
    private let closeButtonTrailingPadding: CGFloat = 16.0

    var body: some View {
        ZStack(alignment: .top) {
            HStack {
                Spacer()

                Button {
                    closeTapAction?()
                } label: {
                    Image(systemName: "xmark.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: closeButtonSize.width,
                               height: closeButtonSize.height)
                        .foregroundColor(.black)
                }
                .padding(EdgeInsets(top: closeButtonTopPadding,
                                    leading: 0,
                                    bottom: 0,
                                    trailing: closeButtonTrailingPadding))
            }

            Capsule()
                .fill(.black)
                .frame(width: capsuleSize.width, height: capsuleSize.height)
                .padding(.top, capsuleTopPadding)
        }
    }
}
