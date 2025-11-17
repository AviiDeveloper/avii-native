import SwiftUI

struct SessionCardView: View {
    let session: SessionCard

    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            VStack(alignment: .leading, spacing: 6) {
                Text(session.title)
                    .font(.headline)
                Text(session.detail)
                    .font(.subheadline)
                    .foregroundStyle(AviiTheme.mutedText)
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text(session.duration)
                    .font(.subheadline)
                    .bold()
                Button("Start") {}
                    .font(.footnote.bold())
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(AviiTheme.accentGradient)
                    .clipShape(Capsule())
            }
        }
        .padding(16)
        .background(AviiTheme.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .overlay(
            RoundedRectangle(cornerRadius: 18)
                .stroke(AviiTheme.border)
        )
    }
}

#Preview {
    SessionCardView(session: MockData.sessions.first!)
        .preferredColorScheme(.dark)
        .padding()
}
