//
//  InformationView.swift
//  SeatReservation
//
//  Created by student on 10/5/2024.
//

import SwiftUI

struct InformationView: View {
    var myimage: String
    var title: String
    var address: String
    var description: String
    
    var body: some View {
        VStack(spacing: 16) {
            ZStack(alignment: .bottom) {
                // Display an image
                Image(myimage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                
                // Add a semi-transparent black rectangle as a background for the text
                Rectangle()
                    .foregroundColor(Color.black.opacity(0.5))
                    .frame(height: 60)
                
                // Display the title text on top of the image
                Text(title)
                    .font(.title)
                    .foregroundColor(.white)
                    .padding(.horizontal)
                    .padding()
                    .bold()
            }
            
            VStack(alignment: .leading) {
                // Display the "Where" section title
                Text("Where: ")
                    .font(.title)
                    .bold()
                 
                // Display the address
                Text(address)
                    .font(.body)
                
                // Display the "Introduction" section title
                Text("Introduction:")
                    .font(.title)
                    .bold()
                
                // Display the description
                Text(description)
                    .font(.body)
            }
            
            Spacer()
           
            // Create a navigation link to the ReservationView
            NavigationLink(destination: ReservationView(title: self.title, image: self.myimage)) {
                HStack {
                    // Display the "Reservate" button
                    Text("🗓️Reservate")
                        .font(.title)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.black)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline) // Set the navigation bar title display mode to inline
    }
}

struct InformationView_Previews: PreviewProvider {
    static var previews: some View {
        InformationView(myimage: "image1", title: "QUAY", address: "Upper Level Overseas Passenger Terminal", description: "With sweeping views of the Sydney Opera House and Harbour Bridge from its elevated harbourside perch, Quay is a feast for your eyes and your tastebuds. Many local farmers, producers and artisans cultivate produce exclusively for executive chef Peter Gilmore’s innovative nature-inspired cuisine, which has been picking up top awards for nearly 20 years.")
    }
}


