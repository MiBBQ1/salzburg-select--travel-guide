import SwiftUI

struct MainAppView: View {
    @State var selectedCategories: [String] = ["Historical Landmarks", "Best Views"]
    @State private var selectedTab: Int = 0
    
    let locations: [Place] = [
        Place(name: "Hohensalzburg Fortress", category: "Historical Landmarks", latitude: 47.7955, longitude: 13.0474, description: "A medieval fortress offering panoramic views of Salzburg.", imageName: "hohensalzburg"),
        Place(name: "Mozart's Birthplace", category: "Historical Landmarks", latitude: 47.8008, longitude: 13.0434, description: "The birthplace of Wolfgang Amadeus Mozart, now a museum.", imageName: "mozart_birthplace"),
        Place(name: "Residenzplatz", category: "Historical Landmarks", latitude: 47.7973, longitude: 13.0451, description: "A large square in Salzburg's Old Town with beautiful architecture.", imageName: "residenzplatz"),
        Place(name: "St. Peter's Abbey", category: "Historical Landmarks", latitude: 47.7979, longitude: 13.0439, description: "One of the oldest monasteries in Salzburg with stunning views.", imageName: "st_peters_abbey"),
        Place(name: "Salzburg Cathedral", category: "Historical Landmarks", latitude: 47.7972, longitude: 13.0456, description: "A baroque cathedral in the heart of Salzburg.", imageName: "salzburg_cathedral"),
        
        Place(name: "Untersberg Mountain", category: "Best Views", latitude: 47.7356, longitude: 12.9989, description: "A cable car ride to the top offers breathtaking views of Salzburg and the Alps.", imageName: "untersberg"),
        Place(name: "Kapuzinerberg Hill", category: "Best Views", latitude: 47.8003, longitude: 13.0501, description: "A hill with hiking trails and stunning views of Salzburg.", imageName: "kapuzinerberg"),
        Place(name: "Gaisberg Mountain", category: "Best Views", latitude: 47.7974, longitude: 13.1307, description: "A mountain near Salzburg with panoramic views.", imageName: "gaisberg"),
        Place(name: "Festungsbahn Viewpoint", category: "Best Views", latitude: 47.7965, longitude: 13.0477, description: "A scenic viewpoint accessible by the Festungsbahn funicular.", imageName: "festungsbahn"),
        Place(name: "Müllner Steg Bridge", category: "Best Views", latitude: 47.8023, longitude: 13.0405, description: "A pedestrian bridge offering views of the Salzach River.", imageName: "mullner_steg"),
        
        Place(name: "Mozarteum University", category: "Cultural Attractions", latitude: 47.8002, longitude: 13.0448, description: "A prestigious music university in Salzburg.", imageName: "mozarteum"),
        Place(name: "Salzburg Museum", category: "Cultural Attractions", latitude: 47.7970, longitude: 13.0450, description: "A museum showcasing Salzburg's history and culture.", imageName: "salzburg_museum"),
        Place(name: "Marionette Theatre", category: "Cultural Attractions", latitude: 47.7983, longitude: 13.0438, description: "A theater famous for its marionette performances.", imageName: "marionette_theatre"),
        Place(name: "Haus der Natur", category: "Cultural Attractions", latitude: 47.8020, longitude: 13.0435, description: "A natural history and science museum in Salzburg.", imageName: "haus_der_natur"),
        Place(name: "Mozart Dinner Concert", category: "Cultural Attractions", latitude: 47.7983, longitude: 13.0472, description: "A concert with a dinner experience inspired by Mozart.", imageName: "mozart_dinner_concert"),
        
        Place(name: "Augustiner Bräustübl Tavern", category: "Foodie Spots", latitude: 47.8004, longitude: 13.0308, description: "A traditional tavern serving local beer and food.", imageName: "augustiner"),
        Place(name: "St. Peter Stiftskulinarium", category: "Foodie Spots", latitude: 47.7979, longitude: 13.0440, description: "A historic restaurant offering a fine dining experience.", imageName: "st_peter_stiftskulinarium"),
        Place(name: "Cafe Tomaselli", category: "Foodie Spots", latitude: 47.7995, longitude: 13.0464, description: "The oldest coffee house in Austria, serving traditional pastries.", imageName: "cafe_tomaselli"),
        Place(name: "Bärenwirt Restaurant", category: "Foodie Spots", latitude: 47.8020, longitude: 13.0420, description: "A rustic restaurant known for its Austrian cuisine.", imageName: "barenwirt"),
        Place(name: "Afro Cafe", category: "Foodie Spots", latitude: 47.7995, longitude: 13.0442, description: "A vibrant cafe with African-inspired decor and food.", imageName: "afro_cafe"),
        
        Place(name: "Mirabell Gardens", category: "Romantic Places", latitude: 47.8055, longitude: 13.0431, description: "A picturesque garden with fountains and sculptures.", imageName: "mirabell_gardens"),
        Place(name: "Mönchsberg Terrace", category: "Romantic Places", latitude: 47.7979, longitude: 13.0458, description: "A terrace offering panoramic views of Salzburg.", imageName: "monchsberg"),
        Place(name: "Hellbrunn Palace", category: "Romantic Places", latitude: 47.7628, longitude: 13.0670, description: "A baroque palace with beautiful gardens and trick fountains.", imageName: "hellbrunn_palace"),
        Place(name: "St. Peter's Cemetery", category: "Romantic Places", latitude: 47.7979, longitude: 13.0440, description: "A historic cemetery with beautiful tombstones.", imageName: "st_peters_cemetery"),
        Place(name: "Salzach River Promenade", category: "Romantic Places", latitude: 47.7993, longitude: 13.0435, description: "A scenic riverside promenade in Salzburg.", imageName: "salzach_promenade")
    ]
    
    var body: some View {
           ZStack {
               VStack {
                   switch selectedTab {
                   case 0:
                       HomeView(selectedTab: $selectedTab)
                   case 1:
                       CategoriesView(selectedCategories: $selectedCategories, places: locations)
                   case 2:
                       LoaderView(
                           selectedCategories: selectedCategories,
                           places: locations
                       )
                   case 3:
                       MapView(selectedCategories: selectedCategories)
                   case 4:
                       ProfileView()
                   default:
                       HomeView(selectedTab: $selectedTab)
                   }
               }
               .frame(maxWidth: .infinity, maxHeight: .infinity)
               .background(Color.white.ignoresSafeArea())
               
               VStack {
                   Spacer()
                   CustomTabBar(selectedTab: $selectedTab)
               }
           }
       }
   }

  
