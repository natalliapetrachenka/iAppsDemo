# iAppsDemo

Some points: 
- App loads images in background and cache
- Gallery details screen spitted by 4 independs stacks.
- To change position of Views uses spacer to save correct size of views in stack. Offsets wasn't used not to display part of view outbounds of screen.
- If the user taps on dummy view audio player collapses.
- Need to avoid several animations action in one time. It has room for changing concept of working with audio content.
- SwiftUI has lack of detection of user gesteres therefore I use dragging gesture only for audio tracker slider. It will change height when user drags it.
