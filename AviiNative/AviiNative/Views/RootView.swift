import SwiftUI

struct RootView: View {
    @EnvironmentObject var profileStore: ProfileStore
    @AppStorage("avii.hasCompletedOnboarding") private var hasCompletedOnboarding = false

    var body: some View {
        TabView {
            DashboardView()
                .tabItem {
                    Label("Home", systemImage: "square.grid.2x2")
                }

            PlaceholderView(title: "Planner")
                .tabItem {
                    Label("Planner", systemImage: "list.bullet.rectangle")
                }

            PlaceholderView(title: "LiDAR")
                .tabItem {
                    Label("LiDAR", systemImage: "camera.viewfinder")
                }

            ProfilePlaceholderView()
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle")
                }
        }
        .tint(.white)
    }
}

struct PlaceholderView: View {
    let title: String

    var body: some View {
        ZStack {
            AviiTheme.backgroundGradient
                .ignoresSafeArea()
            VStack(spacing: 16) {
                Text(title)
                    .font(.largeTitle.bold())
                Text("Native module coming soon.")
                    .foregroundStyle(AviiTheme.mutedText)
            }
        }
    }
}

struct ProfilePlaceholderView: View {
    @EnvironmentObject var profileStore: ProfileStore
    @AppStorage("avii.hasCompletedOnboarding") private var hasCompletedOnboarding = false

    var body: some View {
        ZStack {
            AviiTheme.backgroundGradient
                .ignoresSafeArea()
            VStack(spacing: 16) {
                Text("Profile coming soon")
                    .font(.largeTitle.bold())
                Text("Manage biometrics, privacy, and app access here.")
                    .foregroundStyle(AviiTheme.mutedText)
                Divider().overlay(Color.white.opacity(0.2))
                Button(role: .destructive) {
                    profileStore.reset()
                    hasCompletedOnboarding = false
                } label: {
                    Text("Reset onboarding")
                        .padding(.horizontal, 24)
                        .padding(.vertical, 10)
                        .background(Color.white.opacity(0.12))
                        .clipShape(Capsule())
                }
            }
            .padding()
        }
    }
}

#Preview {
    RootView()
        .environmentObject(ProfileStore.preview)
        .preferredColorScheme(.dark)
}
