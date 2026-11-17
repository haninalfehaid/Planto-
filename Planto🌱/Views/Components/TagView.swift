import SwiftUI

struct TagView: View {
    let icon: String
    let text: String
    let color: Color

    var body: some View {
        Label(text, systemImage: icon)
            .font(.caption)
            .foregroundStyle(color)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(Color(white: 0.11), in: RoundedRectangle(cornerRadius: 8))
    }
}

#Preview {
    HStack {
        TagView(icon: "sun.max", text: "Full sun", color: .sunYellow)
        TagView(icon: "drop", text: "20-50 ml", color: .waterBlue)
    }
    .padding()
    .preferredColorScheme(.dark)
}
