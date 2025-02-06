import SwiftUI

struct HomeView: View {
    @Binding var selectedTab: Int
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Image("Group 2 (8)")
                    .resizable()
                    .scaledToFit()
                    .frame(width: geometry.size.width * 0.6) 
                    .padding(.top, geometry.size.height * 0.03)
                
                Image("MAIN_IMAGE")
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(10)
                    .padding(.horizontal, geometry.size.width * 0.05)
                    .padding(.top, geometry.size.height * 0.02)
                
                VStack(alignment: .leading, spacing: geometry.size.height * 0.015) {
                    Text("Welcome to Salzburg")
                        .font(.custom("Inknut Antiqua", size: geometry.size.width * 0.06))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("""
Nestled in the heart of the Austrian Alps, Salzburg is a city of timeless charm. Known as the birthplace of Mozart and the filming location of The Sound of Music, it’s a treasure trove of culture, history, and natural beauty. From stunning baroque architecture to breathtaking mountain views, Salzburg invites you to explore its hidden gems and iconic landmarks. Let’s begin your journey!
""")
                        .font(.custom("Inknut Antiqua", size: geometry.size.width * 0.045))
                        .foregroundColor(.white)
                }
                .padding(.horizontal, geometry.size.width * 0.05)
                .padding(.top, geometry.size.height * 0.02)
                
                Spacer()
                
                Button(action: {
                    selectedTab = 3
                }) {
                    Text("Open the map")
                        .frame(maxWidth: .infinity)
                        .padding(geometry.size.height * 0.02)
                        .background(Color.white)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                        .padding(.horizontal, geometry.size.width * 0.05)
                }
                
                Spacer()
            }
            .padding(.bottom, geometry.size.height * 0.1)
            .background(
                Color(hex: "#1B1B1B") 
                    .edgesIgnoringSafeArea(.all)
            )
        }
    }
}
