import SwiftUI

struct AviiTheme {
    static let backgroundGradient = LinearGradient(
        gradient: Gradient(colors: [Color(hex: 0x040013), Color(hex: 0x09092a), Color(hex: 0x0f1838)]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    static let accentGradient = LinearGradient(
        gradient: Gradient(colors: [Color(hex: 0x8368ff), Color(hex: 0xa230ff)]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    static let secondaryGradient = LinearGradient(
        gradient: Gradient(colors: [Color(hex: 0x31d4c8), Color(hex: 0x2096d6)]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    static let cardBackground = Color.white.opacity(0.06)
    static let border = Color.white.opacity(0.12)
    static let mutedText = Color.white.opacity(0.65)
}

extension Color {
    init(hex: UInt, alpha: Double = 1.0) {
        let red = Double((hex >> 16) & 0xff) / 255
        let green = Double((hex >> 8) & 0xff) / 255
        let blue = Double(hex & 0xff) / 255
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: alpha)
    }
}
