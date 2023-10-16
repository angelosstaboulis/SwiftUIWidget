//
//  WidgetDate.swift
//  WidgetDate
//
//  Created by Angelos Staboulis on 16/10/23.
//

import WidgetKit
import SwiftUI

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationAppIntent())
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: configuration)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        return Timeline(entries: entries, policy: .atEnd)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
}

struct WidgetDateEntryView : View {
    var entry: Provider.Entry
    var body: some View {
        VStack {
            Color.blue.overlay {
                VStack{
                    Text("Date").foregroundStyle(.white)
                    Text(getDate()).foregroundStyle(.white)
                    Spacer()
                    Text("Time").foregroundStyle(.white)
                    Text(getTime()).foregroundStyle(.white)
                }.frame(width: 300, height: 30, alignment: .center)
                   
                
                
            }.frame(width: 300, height: 150, alignment: .leading)
         
        }.frame(width: 300, height: 150, alignment: .leading)
    }
    func getDate()->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateFormatter.dateFormat = "EEEE dd/MM/yyyy"
        return dateFormatter.string(from: Date())
    }
    func getTime()->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateFormatter.dateFormat = "hh:mm:ss"
    
        return dateFormatter.string(from: Date())
    }
}

struct WidgetDate: Widget {
    let kind: String = "WidgetDate"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            WidgetDateEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
    }
}

extension ConfigurationAppIntent {
    fileprivate static var smiley: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "😀"
        return intent
    }
    
    fileprivate static var starEyes: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "🤩"
        return intent
    }
}

#Preview(as: .systemSmall) {
    WidgetDate()
} timeline: {
    SimpleEntry(date: .now, configuration: .smiley)
    SimpleEntry(date: .now, configuration: .starEyes)
}
