import SwiftUI

struct LoaderView: View {
    @State private var isAnimating = false
    @State private var showPlaceInfo = false
    @State private var selectedPlace: Place?
    @State private var showCategorySelector = false 
    @State var selectedCategories: [String]
    var places: [Place]

    var body: some View {
        ZStack {
            VStack(spacing: 40) {
                Image("Group 2 (8)")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 90)
                    .padding(.top, 16)

                ZStack {
                    Circle()
                        .fill(Color(hex: "#1B1B1B"))
                        .frame(width: 220, height: 220)
                        .shadow(color: Color.black.opacity(0.8), radius: 10, x: 10, y: 10)
                        .overlay(
                            Circle()
                                .stroke(Color.gray.opacity(0.5), lineWidth: 4)
                        )

                    ForEach(0..<12) { index in
                        Circle()
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [Color.gray, Color.black]),
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                            .frame(width: 25, height: 25)
                            .offset(y: -90)
                            .rotationEffect(.degrees(Double(index) * 30))
                            .shadow(color: Color.black.opacity(0.5), radius: 5, x: 2, y: 2)
                            .scaleEffect(isAnimating ? 0.8 : 1.0)
                            .opacity(isAnimating ? 0.5 : 1.0)
                            .animation(
                                Animation.easeInOut(duration: 1.5)
                                    .repeatForever(autoreverses: true),
                                value: isAnimating
                            )
                    }

                    Text("LOADING...")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(.white)
                        .shadow(color: Color.gray.opacity(0.8), radius: 5, x: 0, y: 0)
                }
                .rotation3DEffect(
                    Angle(degrees: 25),
                    axis: (x: 1.0, y: 0.0, z: 0.0)
                )

                Button(action: {
                    startSearch()
                }) {
                    Text("Search")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.black)
                        .frame(width: 220, height: 50)
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 2, y: 2)
                }

                Button(action: {
                    showCategorySelector = true
                }) {
                    Text("Setup Categories")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.white)
                        .frame(width: 220, height: 50)
                        .background(Color.gray.opacity(0.8))
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 2, y: 2)
                }
            }
            .offset(y: -30)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(hex: "#1B1B1B").edgesIgnoringSafeArea(.all))
        .sheet(isPresented: $showCategorySelector) {
            CategorySelectorView(selectedCategories: $selectedCategories)
        }
        .sheet(isPresented: $showPlaceInfo) {
            if let place = selectedPlace {
                PlaceInfoView(place: place)
            }
        }
    }

    private func startSearch() {
     
        isAnimating = true

        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            isAnimating = false
            selectRandomPlace()
        }
    }

    private func selectRandomPlace() {
        let filteredPlaces = places.filter { selectedCategories.contains($0.category) }
        selectedPlace = filteredPlaces.randomElement()
        showPlaceInfo = true
    }
}

struct CategorySelectorView: View {
    @Binding var selectedCategories: [String]
    let allCategories = ["Romantic Places", "Historical Landmarks", "Best Views", "Cultural Attractions", "Foodie Spots"]

    var body: some View {
        VStack {
            Image("Group 2 (8)")
                .resizable()
                .scaledToFit()
                .frame(height: 80)
                .padding(.top, 16)

            Spacer()

            VStack(spacing: 16) {
                ForEach(allCategories, id: \.self) { category in
                    Button(action: {
                        if selectedCategories.contains(category) {
                            selectedCategories.removeAll { $0 == category }
                        } else {
                            selectedCategories.append(category)
                        }
                    }) {
                        Text(category)
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(selectedCategories.contains(category) ? .white : .white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(selectedCategories.contains(category) ? Color.gray : Color.clear)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.white, lineWidth: 2)
                                    )
                            )
                    }
                }
            }
            .padding(.horizontal, 24)

            Spacer()

            Button(action: {
                UIApplication.shared.windows.first?.rootViewController?.dismiss(animated: true, completion: nil)
            }) {
                Text("Setup")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 2, y: 2)
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 16)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(hex: "#1B1B1B").edgesIgnoringSafeArea(.all))
    }
}
