import Foundation
import SwiftUI

struct WellnessMetric: Identifiable {
    let id = UUID()
    let label: String
    let value: String
    let change: String
}

struct FocusCard: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let icon: String
    let gradient: LinearGradient
}

struct SessionCard: Identifiable {
    let id = UUID()
    let title: String
    let duration: String
    let detail: String
}

enum MockData {
    static let metrics: [WellnessMetric] = [
        .init(label: "Recovery", value: "92%", change: "+4%"),
        .init(label: "Sleep", value: "7h 48m", change: "+32m"),
        .init(label: "Calories", value: "2,180", change: "Balanced"),
    ]

    static let focus: [FocusCard] = [
        .init(
            title: "Mobility",
            subtitle: "Add a five-minute hip flow",
            icon: "figure.cooldown",
            gradient: AviiTheme.secondaryGradient
        ),
        .init(
            title: "Strength",
            subtitle: "Progressive overload week",
            icon: "bolt.heart",
            gradient: AviiTheme.accentGradient
        ),
    ]

    static let sessions: [SessionCard] = [
        .init(title: "Metabolic Circuit", duration: "28 min", detail: "Kettlebell + tempo runs"),
        .init(title: "Guided Mobility", duration: "12 min", detail: "Thoracic + ankle release"),
        .init(title: "Recovery Breath", duration: "8 min", detail: "Box breathing + HRV"),
    ]
}
