import SwiftUI
import MapKit

struct PlaceInfoView: View {
    var place: Place
    @Environment(\.presentationMode) var presentationMode
    @State private var showShareSheet = false
    @State private var isLiked = false

    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Color(hex: "#1B1B1B")
                    .edgesIgnoringSafeArea(.top)

                HStack {
                    Image("Group 2 (8)")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 80)

                    Spacer()

                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.white)
                            .font(.title2)
                            .padding(.trailing, 16)
                    }
                }
                .padding(.leading, 16)
            }
            .frame(height: 100)
            .background(Color(hex: "#1B1B1B"))
            .edgesIgnoringSafeArea(.top)

            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
               
                    ZStack(alignment: .topTrailing) {
                        Image(place.imageName)
                            .resizable()
                            .scaledToFill()
                            .frame(height: 200)
                            .cornerRadius(12)
                            .clipped()

                        HStack {
                            Text(place.category)
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding(.vertical, 4)
                                .padding(.horizontal, 8)
                                .background(Color(hex: "#1B1B1B").opacity(0.7))
                                .cornerRadius(8)

                            Spacer()
                        }
                        .padding()

                        HStack(spacing: 12) {
                            Button(action: {
                                showShareSheet = true
                            }) {
                                Image(systemName: "square.and.arrow.up")
                                    .foregroundColor(.white)
                                    .font(.title2)
                                    .padding()
                                    .background(Color(hex: "#1B1B1B").opacity(0.7))
                                    .clipShape(Circle())
                            }

                            Button(action: {
                                toggleLike()
                            }) {
                                Image(systemName: isLiked ? "heart.fill" : "heart")
                                    .foregroundColor(isLiked ? .red : .white)
                                    .font(.title2)
                                    .padding()
                                    .background(Color(hex: "#1B1B1B").opacity(0.7))
                                    .clipShape(Circle())
                            }
                        }
                        .padding(.trailing, 16)
                        .padding(.top, 16)
                    }

                    Text(place.name)
                        .font(.title)
                        .bold()
                        .foregroundColor(.white)

                    Text(place.description)
                        .font(.body)
                        .foregroundColor(.white)

                    Text("Working Hours: 8:30 AM - 4:00 PM")
                        .font(.subheadline)
                        .foregroundColor(.gray)

                    Text("Coordinates: \(place.latitude), \(place.longitude)")
                        .font(.subheadline)
                        .foregroundColor(.gray)

                    Button(action: {
                        openInAppleMaps(latitude: place.latitude, longitude: place.longitude, placeName: place.name)
                    }) {
                        Text("Open in Apple Maps")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(Color.white)
                            .foregroundColor(.black)
                            .cornerRadius(12)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 16)
            }
            .background(Color(hex: "#1B1B1B"))
        }
        .background(Color(hex: "#1B1B1B").edgesIgnoringSafeArea(.all))
        .sheet(isPresented: $showShareSheet) {
            ShareSheet(activityItems: [
                "Check out this place: \(place.name)",
                "Coordinates: \(place.latitude), \(place.longitude)",
                URL(string: "https://maps.apple.com/?ll=\(place.latitude),\(place.longitude)")!
            ])
        }
        .onAppear {
            isLiked = isPlaceLiked(place: place)
        }
    }

    private func openInAppleMaps(latitude: Double, longitude: Double, placeName: String) {
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate))
        mapItem.name = placeName
        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
    }

    private func toggleLike() {
        if isLiked {
            removePlaceFromLikes(place: place)
        } else {
            savePlaceToLikes(place: place)
        }
        isLiked.toggle()
    }
}

func savePlaceToLikes(place: Place) {
    var likedPlaces = UserDefaults.standard.array(forKey: "likedPlaces") as? [[String: Any]] ?? []
    let placeData: [String: Any] = [
        "name": place.name,
        "category": place.category,
        "latitude": place.latitude,
        "longitude": place.longitude,
        "description": place.description,
        "imageName": place.imageName
    ]
    likedPlaces.append(placeData)
    UserDefaults.standard.set(likedPlaces, forKey: "likedPlaces")
}

func removePlaceFromLikes(place: Place) {
    var likedPlaces = UserDefaults.standard.array(forKey: "likedPlaces") as? [[String: Any]] ?? []
    likedPlaces.removeAll { $0["name"] as? String == place.name }
    UserDefaults.standard.set(likedPlaces, forKey: "likedPlaces")
}

func isPlaceLiked(place: Place) -> Bool {
    let likedPlaces = UserDefaults.standard.array(forKey: "likedPlaces") as? [[String: Any]] ?? []
    return likedPlaces.contains { $0["name"] as? String == place.name }
}

struct ShareSheet: UIViewControllerRepresentable {
    var activityItems: [Any]
    var applicationActivities: [UIActivity]? = nil

    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}
