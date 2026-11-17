import SwiftUI

struct WateringProgressView: View {
    let message: String
    let progress: Double

    var body: some View {
        VStack(spacing: 12) {
            Text(message)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .contentTransition(.numericText())

            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(Color(white: 0.17))
                    Capsule()
                        .fill(Color.plantGreen)
                        .frame(width: geo.size.width * progress)
                }
            }
            .frame(height: 8)
        }
        .padding(.horizontal)
        .animation(.spring(duration: 0.5), value: progress)
    }
}

#Preview {
    WateringProgressView(message: "3 of your plants feel loved today ✨", progress: 0.75)
        .padding()
        .preferredColorScheme(.dark)
}
