import SwiftUI

// Opening splash screen for the Tim Hortons app.
struct SplashView: View {
    
    @State private var showApp = false
    
    var body: some View {
        if showApp {
            ContentView()
        } else {
            ZStack {
                Color.red
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    Image("TimLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 180, height: 180)
                        .clipShape(RoundedRectangle(cornerRadius: 30))
                    
                    Text("Tim Hortons Run")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("Team Coffee Orders")
                        .font(.headline)
                        .foregroundColor(.white.opacity(0.9))
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    showApp = true
                }
            }
        }
    }
}
