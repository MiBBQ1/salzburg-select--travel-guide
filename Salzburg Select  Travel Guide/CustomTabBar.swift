import SwiftUI

struct CustomTabBar: View {
    @Binding var selectedTab: Int
    
    var body: some View {
        HStack {
            Spacer()
            
            TabBarButton(icon: "house.fill", index: 0, selectedTab: $selectedTab)
            
            Spacer()
            
            TabBarButton(icon: "line.3.horizontal", index: 1, selectedTab: $selectedTab)
            
            Spacer()
            
            TabBarButton(icon: "film.fill", index: 2, selectedTab: $selectedTab)
            
            Spacer()
            
            TabBarButton(icon: "map.fill", index: 3, selectedTab: $selectedTab)
            
            Spacer()
            
            TabBarButton(icon: "person.fill", index: 4, selectedTab: $selectedTab)
            
            Spacer()
        }
        .frame(height: 60)
        .background(Color.black)
        .cornerRadius(20)
        .padding()
    }
}

struct TabBarButton: View {
    var icon: String
    var index: Int
    @Binding var selectedTab: Int
    
    var body: some View {
        Button(action: {
            selectedTab = index
        }) {
            ZStack {
                if selectedTab == index {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white)
                        .frame(width: 50, height: 50)
                }
                Image(systemName: icon)
                    .foregroundColor(selectedTab == index ? .black : .white)
                    .frame(width: 50, height: 50)
            }
        }
    }
}
