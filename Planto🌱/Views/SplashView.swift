import SwiftUI

struct SplashView: View {
    @State private var appear = false

    var body: some View {
        VStack(spacing: 16) {
            Image("plantMascot")
                .resizable()
                .scaledToFit()
                .frame(width: 140, height: 170)
                .scaleEffect(appear ? 1 : 0.7)
                .opacity(appear ? 1 : 0)

            Text("Planto")
                .font(.largeTitle.bold())
                .foregroundStyle(Color.plantGreen)
                .opacity(appear ? 1 : 0)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
        .onAppear {
            withAnimation(.spring(duration: 0.8)) { appear = true }
        }
    }
}

#Preview {
    SplashView()
}
