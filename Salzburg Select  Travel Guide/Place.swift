import Foundation

    struct Place: Identifiable {
        let id = UUID()
        let name: String
        let category: String
        let latitude: Double
        let longitude: Double
        let description: String
        let imageName: String
    }
