//
//  WidgetDateLiveActivity.swift
//  WidgetDate
//
//  Created by Angelos Staboulis on 16/10/23.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct WidgetDateAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct WidgetDateLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: WidgetDateAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension WidgetDateAttributes {
    fileprivate static var preview: WidgetDateAttributes {
        WidgetDateAttributes(name: "World")
    }
}

extension WidgetDateAttributes.ContentState {
    fileprivate static var smiley: WidgetDateAttributes.ContentState {
        WidgetDateAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: WidgetDateAttributes.ContentState {
         WidgetDateAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: WidgetDateAttributes.preview) {
   WidgetDateLiveActivity()
} contentStates: {
    WidgetDateAttributes.ContentState.smiley
    WidgetDateAttributes.ContentState.starEyes
}
