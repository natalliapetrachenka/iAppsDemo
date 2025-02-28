//
//  AudioPalyerView.swift
//  iAppDemo
//
//  Created by Natallia Petrachenka on 24.02.25.
//

import SwiftUI

struct AudioPlayerView: View {
    @State private var playerHeight: CGFloat
    private let maxPlayerHeight: CGFloat
    private let minPlayerHeight: CGFloat
    private let playerTrailingPadding: CGFloat = 8.0
    private let playerBackgroundColor: Color
    private let playerBackgroundOpacity: CGFloat = 0.5

    @State private var isAudioDetailsHidden: Bool = true

    private let contentHeaderOpacity: CGFloat = 1.0
    private let percentContentHeight: CGFloat = 0.6
    private let contentBottomPadding: CGFloat = 10.0

    private let playerControlViewHeight: CGFloat = 44.0

    private let audioTrackHeight: CGFloat
    @State private var audioTrackProgress: CGFloat = 0

    @Binding private var isExpanded: Bool
    @State private var presentDimmedView: Bool = false

    private let separatorHeight: CGFloat

    private let details: AudioDetails

    init(details: AudioDetails,
         maxPlayerHeight: CGFloat,
         minPlayerHeight: CGFloat,
         audioTrackHeight: CGFloat,
         separatorHeight: CGFloat,
         backgroundColor: Color,
         isExpanded: Binding<Bool>) {

        self.details = details

        self.separatorHeight = separatorHeight

        let maxHeight = maxPlayerHeight > 0 ? maxPlayerHeight : 0
        let minHeight = minPlayerHeight > 0 ? minPlayerHeight : 0

        self.playerHeight = minHeight
        self.maxPlayerHeight = maxHeight
        self.minPlayerHeight = minHeight

        self.playerBackgroundColor = backgroundColor

        self.audioTrackHeight = audioTrackHeight

        _isExpanded = isExpanded
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            Color
                .black.opacity(0.5)
                .opacity(presentDimmedView ? playerBackgroundOpacity : 0)
                .ignoresSafeArea(.all)
                .onTapGesture {
                    minimizePlayerAndUpdateExpandedStateIfNeeded()
                }

            VStack(spacing: 0) {
                playerView
                    .frame(height: playerHeight)
                    .background(playerBackgroundColor)
                    .gesture(dragGesture)
                    .onChange(of: isExpanded) { _, value in
                        if value {
                            expandPlayer()
                        } else {
                            minimizePlayer()
                        }
                    }
                    .onChange(of: maxPlayerHeight) { oldValue, value in
                        if isExpanded {
                            playerHeight = maxPlayerHeight
                        }
                    }

                AudioTrackSlider(progress: $audioTrackProgress,
                                 minTrackHeight: audioTrackHeight,
                                 maxTrackHeight: audioTrackHeight * 2,
                                 progressBarColor: .blue,
                                 backgroundBarColor: .cyan)
            }
            .background(playerBackgroundColor)

        }
        .frame(maxHeight: .infinity)
    }

    private var playerView: some View {
        ZStack(alignment: .top) {
            AudioDetailsHeader() {
                minimizePlayer()
            }
            .opacity(isAudioDetailsHidden ? 0 : contentHeaderOpacity)

            VStack(spacing: 0) {
                Spacer()
                    .frame(maxWidth: .infinity)
                    .frame(height: separatorHeight)
                    .background(.black)

                Spacer()
                    .frame(minHeight: 0)

                ZStack {
                    AudioDetailsView(details: details)
                        .padding(.bottom, contentBottomPadding)
                        .opacity(isAudioDetailsHidden ? 0 : contentHeaderOpacity)

                    Spacer()
                        .frame(minHeight: 0)
                }
                .frame(height: calculateContentHeight(height: playerHeight))

                AudioPlayerControlView()
                    .frame(height: playerControlViewHeight)

                Spacer()
                    .frame(minHeight: 0)

                Spacer()
                    .frame(maxWidth: .infinity)
                    .frame(height: separatorHeight)
                    .background(.black)
            }
        }
    }

    private var dragGesture: some Gesture {
        DragGesture()
            .onChanged({ value in
                let newHeight = playerHeight - value.translation.height
                let height = min(max(newHeight, minPlayerHeight), maxPlayerHeight)

                playerHeight = height

                if height == maxPlayerHeight {
                    if isAudioDetailsHidden {
                        isAudioDetailsHidden = false
                    }

                    if !presentDimmedView {
                        presentDimmedView = true
                    }

                } else {
                    if !isAudioDetailsHidden {
                        isAudioDetailsHidden = true
                    }

                    if playerHeight == minPlayerHeight {
                        if presentDimmedView {
                            presentDimmedView = false
                        }
                    }
                }
            })
            .onEnded { value in
                let height = playerHeight - value.translation.height
                if height > maxPlayerHeight / 2 || playerHeight > maxPlayerHeight / 2 {
                    expandPlayerAndUpdateExpandedStateIfNeeded()
                } else {
                    minimizePlayerAndUpdateExpandedStateIfNeeded()
                }
            }
    }

    private func expandPlayerAndUpdateExpandedStateIfNeeded() {
        if !isExpanded {
            isExpanded = true
        } else {
            expandPlayer()
        }
    }

    private func minimizePlayerAndUpdateExpandedStateIfNeeded() {
        if isExpanded {
            isExpanded = false
        } else {
            minimizePlayer()
        }
    }

    private func expandPlayer() {
        guard playerHeight != maxPlayerHeight else { return }

        withAnimation {
            playerHeight = maxPlayerHeight
            presentDimmedView = true
            isAudioDetailsHidden = false
        }
    }

    private func minimizePlayer() {
        guard playerHeight != minPlayerHeight else { return }

        withAnimation {
            playerHeight = minPlayerHeight
            presentDimmedView = false
            isAudioDetailsHidden = true
        }
    }

    private func calculateContentHeight(height: CGFloat) -> CGFloat {
        let maxHeight = maxPlayerHeight
        let minHeight = minPlayerHeight
        guard maxHeight > minHeight && height > minHeight else { return 0 }
        let percent = (height - minHeight)/(maxHeight - minHeight)
        let value = (height * percentContentHeight) * percent
        return value >= 0 ? value : 0
    }

}

#Preview {
    @Previewable @State var isExpanded = false

    let audioTitle: String = "An audio title"
    let audioDescription: String = "Leroy ipsum dolor sit amet, consectetur adipiscing elit. Suspendensse vulputate ac dolor sed vehicula. Nam risus purus, sodalis non ullamcorper sed, commodo in metus. Donec non ornare magna. Nulla vel ipsum ac justo"

    let details = AudioDetails(title: audioTitle, description: audioDescription)

    AudioPlayerView(details: details,
                    maxPlayerHeight: 400,
                    minPlayerHeight: 60,
                    audioTrackHeight: 10,
                    separatorHeight: 1,
                    backgroundColor: .gray,
                    isExpanded: $isExpanded)
    .offset(y: -100)
}
