import SwiftUI

struct DashboardView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                header
                metrics
                focus
                sessions
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 32)
        }
        .background(AviiTheme.backgroundGradient.ignoresSafeArea())
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Welcome back, Avii")
                .font(.title.bold())
            Text("Your recovery looks strong. Keep the LiDAR scans coming for more precise coaching.")
                .font(.subheadline)
                .foregroundStyle(AviiTheme.mutedText)
        }
    }

    private var metrics: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Today\'s readiness")
                .font(.headline)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(MockData.metrics) { metric in
                        MetricCard(metric: metric)
                    }
                }
            }
        }
    }

    private var focus: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Focus tiles")
                .font(.headline)
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                ForEach(MockData.focus) { card in
                    FocusCardView(card: card)
                }
            }
        }
    }

    private var sessions: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Quick sessions")
                .font(.headline)
            VStack(spacing: 12) {
                ForEach(MockData.sessions) { session in
                    SessionCardView(session: session)
                }
            }
        }
    }
}

#Preview {
    DashboardView()
        .preferredColorScheme(.dark)
}
