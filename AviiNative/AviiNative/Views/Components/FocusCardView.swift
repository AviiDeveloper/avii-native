import SwiftUI

struct FocusCardView: View {
    let card: FocusCard

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Image(systemName: card.icon)
                .font(.title3)
                .padding(10)
                .background(Color.white.opacity(0.15))
                .clipShape(Circle())
            Text(card.title)
                .font(.title3)
                .bold()
            Text(card.subtitle)
                .font(.subheadline)
                .foregroundStyle(AviiTheme.mutedText)
            Spacer()
            Button("View guidance") {}
                .font(.subheadline.weight(.semibold))
                .padding(.vertical, 8)
                .frame(maxWidth: .infinity)
                .background(Color.white.opacity(0.15))
                .clipShape(RoundedRectangle(cornerRadius: 14))
        }
        .padding()
        .frame(maxWidth: .infinity, minHeight: 180)
        .background(card.gradient)
        .clipShape(RoundedRectangle(cornerRadius: 26))
        .overlay(
            RoundedRectangle(cornerRadius: 26)
                .stroke(Color.white.opacity(0.15))
        )
    }
}

#Preview {
    FocusCardView(card: MockData.focus.first!)
        .preferredColorScheme(.dark)
        .padding()
}
