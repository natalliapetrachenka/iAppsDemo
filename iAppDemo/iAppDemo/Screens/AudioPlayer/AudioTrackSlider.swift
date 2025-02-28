//
//  AudioTrackSlider.swift
//  iAppDemo
//
//  Created by Natallia Petrachenka on 24.02.25.
//

import SwiftUI

struct AudioTrackSlider: View {
    @Binding var progress: CGFloat
    let minTrackHeight: CGFloat
    let maxTrackHeight: CGFloat

    @State private var isDragging: Bool = false

    let progressBarColor: Color
    let backgroundBarColor: Color

    var body: some View {
        GeometryReader { geometry in
            Rectangle()
                .frame(maxWidth: .infinity)
                .foregroundColor(backgroundBarColor)
                .overlay (
                    Rectangle()
                        .frame(width: progress * geometry.size.width)
                        .foregroundColor(progressBarColor),
                    alignment: .leading
                )
                .onTapGesture(perform: { location in
                    updateProgress(for: location.x, width: geometry.size.width)
                })
                .gesture(
                    DragGesture()
                        .onChanged { gesture in
                            updateProgress(for: gesture.location.x, width: geometry.size.width)
                            if !isDragging {
                                isDragging = true
                            }
                        }
                        .onEnded { gesture in
                            withAnimation {
                                updateProgress(for: gesture.location.x, width: geometry.size.width)
                                isDragging = false
                            }
                        }
                )
        }
        .frame(height: isDragging ? maxTrackHeight : minTrackHeight)
    }

    func updateProgress(for x: CGFloat, width: CGFloat) {
        let newValue = width == 0 ? 0 : (x / width)
        progress = min(max(newValue, 0), 1)
    }
}

#Preview {
    @Previewable @State var progress: CGFloat = 1
    AudioTrackSlider(progress: $progress,
                     minTrackHeight: 10,
                     maxTrackHeight: 20,
                     progressBarColor: .blue,
                     backgroundBarColor: .gray)
}
