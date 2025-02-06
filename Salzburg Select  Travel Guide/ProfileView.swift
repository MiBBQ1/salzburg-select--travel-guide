import SwiftUI
import UIKit

struct ProfileView: View {
    @State private var likedPlaces: [Place] = []
    @State private var avatarImage: UIImage? = nil 
    @State private var isShowingImagePicker = false
    @State private var inputImage: UIImage? = nil
    @State private var nickname: String = ""
    @State private var isEditingNickname = false

    var body: some View {
        ZStack {
        
            Color(hex: "#1B1B1B")
                .edgesIgnoringSafeArea(.all)

            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
               
                    HStack(spacing: 16) {
                 
                        Button(action: {
                            isShowingImagePicker = true
                        }) {
                            if let avatarImage = avatarImage {
                                Image(uiImage: avatarImage)
                                    .resizable()
                                    .frame(width: 80, height: 80)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            } else {
                                Image(systemName: "photo")
                                    .resizable()
                                    .frame(width: 80, height: 80)
                                    .foregroundColor(.white)
                                    .background(Color.gray.opacity(0.5))
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                        }

                        VStack(alignment: .leading, spacing: 8) {
                            if isEditingNickname {
                                TextField("Enter your nickname", text: $nickname, onCommit: {
                                    saveNickname()
                                    isEditingNickname = false
                                })
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .foregroundColor(.black)
                                .background(Color.white)
                            } else {
                                Text(nickname.isEmpty ? "Salzburg Visitor" : nickname)
                                    .font(.title2)
                                    .foregroundColor(.white)
                                    .onTapGesture {
                                        isEditingNickname = true
                                    }
                            }

                            HStack(spacing: 16) {
                                Button(action: {
                                    isEditingNickname.toggle()
                                    if !isEditingNickname {
                                        saveNickname()
                                    }
                                }) {
                                    Text(isEditingNickname ? "Done" : "Change nickname")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }

                                Button(action: {
                                    resetData()
                                }) {
                                    Text("Reset Data")
                                        .font(.subheadline)
                                        .foregroundColor(.red)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)

                    Text("Saved Locations")
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding(.horizontal)

                    if likedPlaces.isEmpty {
                        VStack {
                            Text("You don't have any saved locations yet.")
                                .font(.body)
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.center)
                                .padding()
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    } else {
                        ForEach(likedPlaces, id: \.id) { place in
                            VStack(alignment: .leading) {
                                ZStack(alignment: .topTrailing) {
                                    Image(place.imageName)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(height: 200)
                                        .cornerRadius(10)
                                        .overlay(
                                            VStack(alignment: .leading) {
                                                Text(place.category)
                                                    .font(.caption)
                                                    .foregroundColor(.white)
                                                    .padding(.vertical, 4)
                                                    .padding(.horizontal, 8)
                                                    .background(Color.black.opacity(0.7))
                                                    .cornerRadius(8)
                                                    .padding(8)
                                            },
                                            alignment: .topLeading
                                        )

                                    HStack {
                                        Button(action: {
                                            deletePlace(place)
                                        }) {
                                            Image(systemName: "trash")
                                                .font(.title3)
                                                .foregroundColor(.red)
                                                .padding(10)
                                                .background(Color.black.opacity(0.7))
                                                .clipShape(Circle())
                                        }
                                    }
                                    .padding(8)
                                }

                                VStack(alignment: .leading, spacing: 8) {
                                    Text(place.name)
                                        .font(.headline)
                                        .foregroundColor(.white)
                                    
                                    Text(place.description)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                        .lineLimit(2)
                                }
                                .padding(.horizontal, 8)
                                .padding(.bottom, 8)
                            }
                            .background(Color.black.opacity(0.8))
                            .cornerRadius(10)
                            .padding(.horizontal)
                        }
                    }
                }
                .padding(.vertical)
            }
        }
        .onAppear {
            loadLikedPlaces()
            loadAvatarImage()
            loadNickname()
        }
        .sheet(isPresented: $isShowingImagePicker, onDismiss: loadInputImage) {
            ImagePicker(image: $inputImage)
        }
    }

    private func resetData() {
        likedPlaces.removeAll()
        avatarImage = nil
        nickname = "User"
        UserDefaults.standard.removeObject(forKey: "likedPlaces")
        UserDefaults.standard.removeObject(forKey: "avatarImage")
        UserDefaults.standard.removeObject(forKey: "nickname")
    }


    private func loadLikedPlaces() {
        let likedPlacesData = UserDefaults.standard.array(forKey: "likedPlaces") as? [[String: Any]] ?? []
        likedPlaces = likedPlacesData.map { data in
            Place(
                name: data["name"] as! String,
                category: data["category"] as! String,
                latitude: data["latitude"] as! Double,
                longitude: data["longitude"] as! Double,
                description: data["description"] as! String,
                imageName: data["imageName"] as! String
            )
        }
    }

    private func loadAvatarImage() {
        if let imageData = UserDefaults.standard.data(forKey: "avatarImage"),
           let image = UIImage(data: imageData) {
            avatarImage = image
        }
    }

    private func saveAvatarImage() {
        guard let inputImage = inputImage else { return }
        if let imageData = inputImage.jpegData(compressionQuality: 0.8) {
            UserDefaults.standard.set(imageData, forKey: "avatarImage")
            avatarImage = inputImage
        }
    }

    private func loadInputImage() {
        guard let inputImage = inputImage else { return }
        avatarImage = inputImage
        saveAvatarImage()
    }

    private func saveNickname() {
        UserDefaults.standard.set(nickname, forKey: "nickname")
    }

    private func loadNickname() {
        if let savedNickname = UserDefaults.standard.string(forKey: "nickname") {
            nickname = savedNickname
        } else {
            nickname = "User"
        }
    }

    private func deletePlace(_ place: Place) {
        likedPlaces.removeAll { $0.name == place.name }
        saveLikedPlaces()
    }

    private func saveLikedPlaces() {
        let likedPlacesData = likedPlaces.map { place in
            [
                "name": place.name,
                "category": place.category,
                "latitude": place.latitude,
                "longitude": place.longitude,
                "description": place.description,
                "imageName": place.imageName
            ]
        }
        UserDefaults.standard.set(likedPlacesData, forKey: "likedPlaces")
    }
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 1
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        let red = Double((rgb >> 16) & 0xFF) / 255.0
        let green = Double((rgb >> 8) & 0xFF) / 255.0
        let blue = Double(rgb & 0xFF) / 255.0
        self.init(red: red, green: green, blue: blue)
    }
}

