//
//  AudioDetailsView.swift
//  iAppDemo
//
//  Created by Natallia Petrachenka on 25.02.25.
//

import SwiftUI

struct AudioDetailsView: View {
    let details: AudioDetails

    private let verticalSpacing: CGFloat = 16

    var body: some View {
        VStack(spacing: verticalSpacing) {
            Text(details.title)
                .font(.largeTitle)
                .bold()
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding([.leading, .trailing])

            Text(details.description)
                .font(.headline)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding([.leading, .trailing])
        }
    }
}
