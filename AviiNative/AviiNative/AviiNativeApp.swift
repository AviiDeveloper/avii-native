//
//  AviiNativeApp.swift
//  AviiNative
//
//  Created by Avii Developer on 17/11/2025.
//

import SwiftUI

@main
struct AviiNativeApp: App {
    @StateObject private var profileStore = ProfileStore()

    var body: some Scene {
        WindowGroup {
            Group {
                if profileStore.hasProfile {
                    RootView()
                } else {
                    OnboardingView()
                }
            }
            .environmentObject(profileStore)
            .preferredColorScheme(.dark)
        }
    }
}
