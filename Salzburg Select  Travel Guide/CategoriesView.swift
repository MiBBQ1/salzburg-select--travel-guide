import SwiftUI

struct CategoriesView: View {
    @Binding var selectedCategories: [String]
    @State private var showCategorySelector = true
    @State private var selectedPlace: Place?
    @State private var showPlaceInfo = false
    @State private var isLoading = false
    let places: [Place]

    var body: some View {
        VStack {
            if showCategorySelector {
                Image("Displayed Categories")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 40) 
                    .padding(.top, 16)

                Spacer()

                VStack(spacing: 16) {
                    ForEach(["Romantic Places", "Historical Landmarks", "Best Views", "Cultural Attractions", "Foodie Spots"], id: \.self) { category in
                        Button(action: {
                            if selectedCategories.contains(category) {
                                selectedCategories.removeAll { $0 == category }
                            } else {
                                selectedCategories.append(category)
                            }
                        }) {
                            Text(category)
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(selectedCategories.contains(category) ? .black : .white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(selectedCategories.contains(category) ? Color.white : Color.clear)
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
            } else {
                Text("Locations list:")
                    .font(.custom("JosefinSans-Bold", size: 24))
                    .foregroundColor(.white)
                    .padding(.top, 16)

                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(places.filter { selectedCategories.contains($0.category) }, id: \.id) { place in
                            Button(action: {
                                loadPlaceInfo(place: place)
                            }) {
                                HStack(alignment: .center, spacing: 16) {
                                    Image(place.imageName)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 80, height: 80)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))

                                    VStack(alignment: .leading, spacing: 8) {
                                        Text(place.name)
                                            .font(.headline)
                                            .foregroundColor(.white)
                                        Text(place.description)
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                            .lineLimit(2)
                                    }

                                    Spacer()
                                }
                                .frame(height: 100)
                                .padding()
                                .background(Color.black.opacity(0.7))
                                .cornerRadius(10)
                                .padding(.horizontal, 16)
                            }
                        }
                    }
                    .padding(.vertical, 16)
                }
            }

            Spacer()

            Button(action: {
                withAnimation {
                    showCategorySelector.toggle()
                }
            }) {
                HStack {
                    Image(systemName: showCategorySelector ? "chevron.up" : "chevron.down")
                    Text(showCategorySelector ? "Setup Categories" : "View Locations")
                }
                .font(.system(size: 16, weight: .medium))
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
        .background(Color(hex: "#1B1B1B").edgesIgnoringSafeArea(.all))
        .overlay(
            Group {
                if isLoading {
                    ZStack {
                        Color.black.opacity(0.5).edgesIgnoringSafeArea(.all)
                        ProgressView("Loading...")
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                }
            }
        )
        .sheet(isPresented: $showPlaceInfo) {
            if let selectedPlace = selectedPlace {
                PlaceInfoView(place: selectedPlace)
            }
        }
    }

    private func loadPlaceInfo(place: Place) {
        isLoading = true

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            selectedPlace = place
            isLoading = false
            showPlaceInfo = true
        }
    }
}
