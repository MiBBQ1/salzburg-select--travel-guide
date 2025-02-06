import SwiftUI

struct FinalOnboardingView: View {
    @Binding var showMainApp: Bool
    @Binding var selectedTab: Int

    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()

                Image("Group 1")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                
                Image("Group 2 (8)")
                    .resizable()
                    .scaledToFit()
                    .frame(width: geometry.size.width * 0.6)
                    .padding(.top, geometry.size.height * 0.03)
                
                Text("Travel Guide.")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.bottom, 30)
                
                VStack(alignment: .center, spacing: 20) {
                    Text("Based on your preferences, we've selected the best spots for you.")
                        .font(.body)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 30)
                    
                    Text("Swipe through your options or view them all on the map.")
                        .font(.body)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 30)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.black.opacity(0.7))
                )
                .padding(.horizontal)
                
                Button(action: {
                    withAnimation {
                        selectedTab = 0
                        showMainApp = true
                    }
                }) {
                    Text("See My Recommendations")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                .padding(.top, 20)
                
                Button(action: {
                    withAnimation {
                        selectedTab = 3
                        showMainApp = true
                    }
                }) {
                    Text("Go to Map")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.clear)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.white, lineWidth: 1)
                        )
                        .foregroundColor(.white)
                        .padding(.horizontal)
                }
                
                Spacer()
            }
            .background(
                Image("ONBOARDING 3") 
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
            )
        }
    }
}
