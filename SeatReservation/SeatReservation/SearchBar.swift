//
//  SearchBar.swift
//  SeatReservation
//
//  Created by student on 10/5/2024.
//

import Foundation
import SwiftUI

// This struct represents a SwiftUI wrapper around a UIKit UISearchBar.
// It allows using a UISearchBar in SwiftUI views.
struct SearchBar: UIViewRepresentable {
    // Binding to keep track of the text entered in the search bar.
    @Binding var text: String

    // Coordinator class to handle events and delegate methods of the UISearchBar.
    class Coordinator: NSObject, UISearchBarDelegate {
        // Binding to keep track of the text entered in the search bar.
        @Binding var text: String

        // Initializer to bind the text value.
        init(text: Binding<String>) {
            _text = text
        }

        // Delegate method called when the text in the search bar changes.
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            // Update the text binding with the new search text.
            text = searchText
        }
    }

    // Function to create and return an instance of the Coordinator.
    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text)
    }

    // Function to create and return a UISearchBar.
    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        // Set the delegate of the search bar to the Coordinator.
        searchBar.delegate = context.coordinator
        return searchBar
    }

    // Function to update the UISearchBar with the latest text value.
    func updateUIView(_ uiView: UISearchBar, context: Context) {
        uiView.text = text
    }
}



