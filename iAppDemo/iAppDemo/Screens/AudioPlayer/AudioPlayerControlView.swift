//
//  AudioPlayerControlView.swift
//  iAppDemo
//
//  Created by Natallia Petrachenka on 24.02.25.
//

import SwiftUI

struct AudioPlayerControlView: View {
    private let buttonSize = CGSizeMake(44.0, 44.0)

    var body: some View {
        HStack {
            Button {

            } label: {
                Image(systemName: "backward.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: buttonSize.width, height: buttonSize.height)
                    .foregroundColor(.black)
            }

            Button {

            } label: {
                Image(systemName: "play.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: buttonSize.width, height: buttonSize.height)
                    .foregroundColor(.black)
            }

            Button {

            } label: {
                Image(systemName: "forward.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: buttonSize.width, height: buttonSize.height)
                    .foregroundColor(.black)
            }
        }
    }
}
