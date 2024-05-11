//
//  ContentView.swift
//  SeatReservation
//
//  Created by student on 10/5/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var searchText = ""
    @State private var sortType: SortType = .name
    var restaurantData = RestaurantData()

    // Label for the current sort type
    var sortTypeLabel: String {
        switch sortType {
        case .name:
            return "Name"
        case .rating:
            return "Rating"
        }
    }
    
    // Filtered list of titles based on the search text
    var filteredTitles: [String] {
        if searchText.isEmpty {
            return restaurantData.mytitle
        } else {
            return restaurantData.mytitle.filter { $0.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    // Sorted list of titles with additional details
    var sortedTitles: [(title: String, imageName: String, popularity: Int, address: String, description: String)] {
        switch sortType {
        case .name:
            return filteredTitles.compactMap { title in
                guard let index = restaurantData.mytitle.firstIndex(of: title) else {
                    return nil
                }
                return (title: title, imageName: restaurantData.image[index], popularity: restaurantData.popularity[index], address: restaurantData.address[index], description: restaurantData.detailDescription[index])
            }.sorted(by: { $0.title < $1.title })
        case .rating:
            return filteredTitles.compactMap { title in
                guard let index = restaurantData.mytitle.firstIndex(of: title) else {
                    return nil
                }
                return (title: title, imageName: restaurantData.image[index], popularity: restaurantData.popularity[index], address: restaurantData.address[index], description: restaurantData.detailDescription[index])
            }.sorted(by: { $0.popularity > $1.popularity })
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                // Search bar for filtering titles
                SearchBar(text: $searchText)
                    .background(Color.clear)
                    .onTapGesture {
                                        // Close the keyboard when tapped outside the search bar
                                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                    }
                HStack {
                    Text("Sort Type: \(sortTypeLabel)")
                        .font(.subheadline)
                        .padding(.top, 8)
                        .padding(.leading, 20)
                        .alignmentGuide(.leading) { dimension in
                            dimension[.leading]
                        }
                    
                    Spacer()
                }
                
                // Picker for selecting sort type
                Picker("Sort Type", selection: $sortType) {
                    Text("Name").tag(SortType.name)
                    Text("Rating").tag(SortType.rating)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 160), spacing: 16)], spacing: 16) {
                        ForEach(sortedTitles, id: \.title) { item in
                            // Extracting values from the tuple
                            let (title, imageName, popularity, address, description) = item
                            NavigationLink(destination: InformationView(myimage: imageName, title: title, address: address, description: description)) {
                                // Displaying a list item with image, title, and popularity
                                ListItem(imageName: imageName, title: title, popularity: popularity)
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 200)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .navigationTitle("Reservation")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    // Navigation link to the list booking view
                    NavigationLink(destination: ListBookingView()) {
                        Image(systemName: "calendar.badge.plus")
                    }
                }
            }
        }
    }
}

enum SortType {
    case name
    case rating
}

struct ListItem: View {
    var imageName: String
    var title: String
    var popularity: Int

    
    var body: some View {
        VStack {
            Spacer() // Pushes the image to the top
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 100)
                .cornerRadius(10)
                .shadow(color: Color.gray, radius: 5, x: 0, y: 0)
            
            Spacer() // Pushes the text and stars to the bottom
            Text(title)
                .font(.headline)
            HStack {
                ForEach(1...5, id: \.self) { number in
                    Image(systemName: number <= popularity ? "star.fill" : "star")
                        .foregroundColor(number <= popularity ? .yellow : .gray)
                }
            }
        }
    }

}

#Preview {
    ContentView()
}
a
