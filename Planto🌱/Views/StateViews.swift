import SwiftUI

struct StartJourneyView: View {
    let onStart: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            Spacer()

            Image("plantMascot")
                .resizable()
                .scaledToFit()
                .frame(width: 160, height: 200)

            Text("Start your plant journey!")
                .font(.title3.bold())

            Text("Now all your plants will be in one place and\nwe will help you take care of them :) 🪴")
                .font(.footnote)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)

            Spacer()

            Button(action: onStart) {
                Text("Set Plant Reminder")
                    .font(.headline)
                    .frame(maxWidth: 260)
                    .padding(.vertical, 6)
            }
            .buttonStyle(.glassProminent)
            .tint(.buttonGreen)

            Spacer()
        }
        .padding()
    }
}

struct AllDoneView: View {
    var body: some View {
        VStack(spacing: 12) {
            Spacer()

            Image("plantWink")
                .resizable()
                .scaledToFit()
                .frame(width: 160, height: 200)

            Text("All Done! 🎉")
                .font(.title3.bold())

            Text("All Reminders Completed")
                .font(.footnote)
                .foregroundStyle(.secondary)

            Spacer()
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview("Start") {
    StartJourneyView(onStart: {}).preferredColorScheme(.dark)
}

#Preview("All Done") {
    AllDoneView().preferredColorScheme(.dark)
}
