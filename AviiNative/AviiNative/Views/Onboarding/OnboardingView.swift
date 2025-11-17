import SwiftUI
import Combine

struct OnboardingView: View {
    @EnvironmentObject var profileStore: ProfileStore
    @StateObject private var viewModel = OnboardingViewModel()

    var body: some View {
        ZStack {
            AviiTheme.backgroundGradient.ignoresSafeArea()
            VStack(spacing: 24) {
                progressHeader
                Spacer(minLength: 0)
                content
                Spacer(minLength: 0)
                actionRow
            }
            .padding(24)
        }
    }

    private var progressHeader: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 8) {
                ForEach(OnboardingStep.allCases, id: \.self) { step in
                    Rectangle()
                        .fill(step.index <= viewModel.step.index ? Color.white : AviiTheme.border)
                        .frame(height: 4)
                        .animation(.easeInOut, value: viewModel.step)
                }
            }
            Text(viewModel.step.title)
                .font(.title.bold())
            Text(viewModel.step.subtitle)
                .font(.subheadline)
                .foregroundStyle(AviiTheme.mutedText)
        }
    }

    @ViewBuilder
    private var content: some View {
        switch viewModel.step {
        case .welcome:
            VStack(alignment: .leading, spacing: 16) {
                Text("Welcome to Avii")
                    .font(.largeTitle.bold())
                Text("We’ll build a personal coach powered by your scans, biomarkers, and goals. Start by sharing a few details.")
                    .foregroundStyle(AviiTheme.mutedText)
                Spacer()
                Image(systemName: "waveform.path.ecg")
                    .font(.system(size: 72))
                    .foregroundStyle(AviiTheme.accentGradient)
            }
            .frame(maxWidth: .infinity, alignment: .leading)

        case .profile:
            VStack(alignment: .leading, spacing: 16) {
                Group {
                    textField("First name", text: $viewModel.firstName)
                    textField("Email (optional)", text: $viewModel.email)
                        .keyboardType(.emailAddress)
                    textField("Height (cm)", text: $viewModel.height)
                        .keyboardType(.decimalPad)
                    textField("Weight (kg)", text: $viewModel.weight)
                        .keyboardType(.decimalPad)
                }
                Spacer()
            }

        case .goals:
            VStack(alignment: .leading, spacing: 18) {
                Text("What should Avii focus on first?")
                    .font(.headline)
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 12), count: 2), spacing: 12) {
                    ForEach(viewModel.availableGoals, id: \.self) { goal in
                        GoalChip(label: goal, isSelected: viewModel.selectedGoals.contains(goal)) {
                            viewModel.toggle(goal)
                        }
                    }
                }
                Text("Select up to three focus areas.")
                    .font(.footnote)
                    .foregroundStyle(AviiTheme.mutedText)
            }
        }
    }

    private func textField(_ title: String, text: Binding<String>) -> some View {
        TextField(title, text: text)
            .padding(.horizontal, 14)
            .padding(.vertical, 12)
            .background(Color.white.opacity(0.06))
            .clipShape(RoundedRectangle(cornerRadius: 14))
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)
            .foregroundStyle(.white)
    }

    private var actionRow: some View {
        VStack(spacing: 12) {
            Button(action: primaryAction) {
                Text(viewModel.step == .goals ? "Finish" : "Continue")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        Group {
                            if viewModel.canContinue {
                                AviiTheme.accentGradient
                            } else {
                                Color.white.opacity(0.1)
                            }
                        }
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 16))
            }
            .buttonStyle(.plain)
            .disabled(!viewModel.canContinue)

            if viewModel.step != .welcome {
                Button("Back", action: viewModel.goBack)
                    .foregroundStyle(Color.white.opacity(0.8))
            } else {
                Button("Skip for now") {
                    let guest = Profile(firstName: "Guest", email: "", height: 0, weight: 0, goals: [])
                    profileStore.update(with: guest)
                }
                .foregroundStyle(Color.white.opacity(0.8))
            }
        }
    }

    private func primaryAction() {
        switch viewModel.step {
        case .welcome:
            viewModel.advance()
        case .profile:
            viewModel.advance()
        case .goals:
            guard let profile = viewModel.buildProfile() else { return }
            profileStore.update(with: profile)
        }
    }
}

private enum OnboardingStep: Int, CaseIterable {
    case welcome
    case profile
    case goals

    var index: Int { rawValue }

    var title: String {
        switch self {
        case .welcome: return "Get started"
        case .profile: return "Your baseline"
        case .goals: return "Focus areas"
        }
    }

    var subtitle: String {
        switch self {
        case .welcome: return "Personalised LiDAR coaching in minutes."
        case .profile: return "Share the basics so calibrations stay accurate."
        case .goals: return "Select up to three themes."
        }
    }
}

private final class OnboardingViewModel: ObservableObject {
    @Published var step: OnboardingStep = .welcome
    @Published var firstName: String = ""
    @Published var email: String = ""
    @Published var height: String = ""
    @Published var weight: String = ""
    @Published var selectedGoals: Set<String> = []

    let availableGoals = ["Mobility", "Recovery", "Strength", "Energy", "Metabolic", "Injury prevention"]

    func advance() {
        if let next = OnboardingStep(rawValue: step.rawValue + 1) {
            step = next
        }
    }

    func goBack() {
        if let prev = OnboardingStep(rawValue: step.rawValue - 1) {
            step = prev
        }
    }

    func toggle(_ goal: String) {
        if selectedGoals.contains(goal) {
            selectedGoals.remove(goal)
        } else if selectedGoals.count < 3 {
            selectedGoals.insert(goal)
        }
    }

    var canContinue: Bool {
        switch step {
        case .welcome:
            return true
        case .profile:
            return !firstName.trimmingCharacters(in: .whitespaces).isEmpty && Double(height) != nil && Double(weight) != nil
        case .goals:
            return !selectedGoals.isEmpty
        }
    }

    func buildProfile() -> Profile? {
        guard let heightValue = Double(height), let weightValue = Double(weight) else { return nil }
        return Profile(
            firstName: firstName.trimmingCharacters(in: .whitespaces),
            email: email.trimmingCharacters(in: .whitespaces),
            height: heightValue,
            weight: weightValue,
            goals: Array(selectedGoals)
        )
    }
}

#Preview {
    OnboardingView()
        .environmentObject(ProfileStore(storage: UserDefaults(suiteName: "avii.onboarding.preview") ?? .standard))
        .preferredColorScheme(.dark)
}
