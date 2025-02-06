import SwiftUI

struct LoadingView: View {
    @Binding var showOnboarding: Bool
    @State private var firstImageVisible: Bool = true
    @State private var secondImageVisible: Bool = false

    var body: some View {
        Group {
            if showOnboarding {
                OnboardingView()
            } else {
                ZStack {
                  
                    Image("background_1")
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                        .opacity(firstImageVisible ? 1 : 0)
                        .animation(.easeInOut(duration: 2.0), value: firstImageVisible)

                    Image("background_2")
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                        .opacity(secondImageVisible ? 1 : 0)
                        .animation(.easeInOut(duration: 2.0), value: secondImageVisible)
                }
                .onAppear {
                
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        firstImageVisible = false
                        secondImageVisible = true
                    }

                    DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                        withAnimation {
                            showOnboarding = true
                        }
                    }
                }
            }
        }
    }
}
