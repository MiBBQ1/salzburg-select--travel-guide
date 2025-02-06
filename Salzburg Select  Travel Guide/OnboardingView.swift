import SwiftUI

struct OnboardingView: View {
    @State private var currentPage = 0
    @State private var selectedCategories: [String] = []
    @State private var showMainApp: Bool = false
    @State private var selectedTab: Int = 0

    let onboardingData = [
        OnboardingPage(imageName: "ONBOARDING 1", title: "Welcome to Salzburg Select", subtitle: "Let's find the perfect spots for you based on your preferences.", buttonTitle: "Get Started"),
        OnboardingPage(imageName: "ONBOARDING 2", title: "What are you in the mood for today?", subtitle: "Select one or more categories to explore.", buttonTitle: "Next")
    ]
    
    let categories = [
        "Romantic Places",
        "Historical Landmarks",
        "Best Views",
        "Cultural Attractions",
        "Foodie Spots"
    ]
    
    var body: some View {
        if showMainApp {
            MainAppView(selectedCategories: selectedCategories)
        } else {
            VStack {
                if currentPage < onboardingData.count {
                    TabView(selection: $currentPage) {
                        OnboardingPageView(page: onboardingData[0])
                            .tag(0)
                        
                        CategorySelectionView(categories: categories, selectedCategories: $selectedCategories)
                            .tag(1)
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    
                    HStack {
                        ForEach(0..<onboardingData.count, id: \.self) { index in
                            Circle()
                                .fill(index == currentPage ? Color.white : Color.gray)
                                .frame(width: 8, height: 8)
                        }
                    }
                    .padding(.top, 10)
                    
                    Button(action: {
                        if currentPage < onboardingData.count - 1 {
                            withAnimation {
                                currentPage += 1
                            }
                        } else {
                            withAnimation {
                                currentPage += 1
                            }
                        }
                    }) {
                        Text(onboardingData[currentPage].buttonTitle)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(selectedCategories.isEmpty ? Color.gray : Color.white)
                            .foregroundColor(selectedCategories.isEmpty ? .white : .black)
                            .cornerRadius(10)
                    }
                    .padding()
                    .disabled(currentPage == 1 && selectedCategories.isEmpty) 
                } else {
                    FinalOnboardingView(showMainApp: $showMainApp, selectedTab: $selectedTab)
                }
            }
            .background(
                Image(currentPage < onboardingData.count ? onboardingData[currentPage].imageName : "ONBOARDING 5")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
            )
        }
    }
}

struct OnboardingPage {
    let imageName: String
    let title: String
    let subtitle: String
    let buttonTitle: String
}

struct OnboardingPageView: View {
    let page: OnboardingPage
    
    var body: some View {
        VStack {
            Spacer()
            Text(page.title)
                .font(.title)
                .bold()
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            Text(page.subtitle)
                .font(.body)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            Spacer()
        }
    }
}

struct CategorySelectionView: View {
    let categories: [String]
    @Binding var selectedCategories: [String]
    
    var body: some View {
        VStack {
            Text("What are you in the mood for today?")
                .font(.title2)
                .bold()
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.bottom, 10)
            
            Text("Select one or more categories to explore.")
                .font(.body)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.bottom, 20)
            
            ForEach(categories, id: \.self) { category in
                Button(action: {
                    if selectedCategories.contains(category) {
                        selectedCategories.removeAll { $0 == category }
                    } else {
                        selectedCategories.append(category)
                    }
                }) {
                    Text(category)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(selectedCategories.contains(category) ? Color.white : Color.gray.opacity(0.5))
                        .foregroundColor(selectedCategories.contains(category) ? .black : .white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
            }
            
            Spacer()
        }
        .padding()
    }
}
