import SwiftUI

struct GoalChip: View {
    let label: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(label)
                .font(.subheadline.weight(.semibold))
                .padding(.horizontal, 14)
                .padding(.vertical, 10)
                .background(isSelected ? AviiTheme.accentGradient : Color.white.opacity(0.08))
                .overlay(
                    RoundedRectangle(cornerRadius: 999)
                        .stroke(isSelected ? Color.clear : AviiTheme.border, lineWidth: 1)
                )
                .clipShape(Capsule())
                .foregroundStyle(Color.white)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    VStack(spacing: 16) {
        GoalChip(label: "Mobility", isSelected: true, action: {})
        GoalChip(label: "Recovery", isSelected: false, action: {})
    }
    .padding()
    .background(AviiTheme.backgroundGradient)
    .preferredColorScheme(.dark)
}
