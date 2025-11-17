import SwiftUI

struct RootView: View {
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

            PlaceholderView(title: "Profile")
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

#Preview {
    RootView()
        .environmentObject(ProfileStore.preview)
        .preferredColorScheme(.dark)
}
