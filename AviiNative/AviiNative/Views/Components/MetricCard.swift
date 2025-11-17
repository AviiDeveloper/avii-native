import SwiftUI

struct MetricCard: View {
    let metric: WellnessMetric

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(metric.label.uppercased())
                .font(.caption)
                .foregroundStyle(AviiTheme.mutedText)
                .tracking(0.8)
            Text(metric.value)
                .font(.system(size: 28, weight: .bold))
            Text(metric.change)
                .font(.subheadline)
                .foregroundStyle(.green)
        }
        .padding(16)
        .frame(width: 160, alignment: .leading)
        .background(AviiTheme.cardBackground)
        .overlay(
            RoundedRectangle(cornerRadius: 18)
                .stroke(AviiTheme.border, lineWidth: 1)
        )
        .clipShape(RoundedRectangle(cornerRadius: 18))
    }
}

#Preview {
    MetricCard(metric: MockData.metrics.first!)
        .preferredColorScheme(.dark)
}
