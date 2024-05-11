//
//  ReservationView.swift
//  SeatReservation
//
//  Created by student on 10/5/2024.
//

import SwiftUI

struct ReservationView: View {
    var title: String
    var image: String
    
    // Enumeration for seat status
    enum SeatStatus {
        case available
        case booked
    }
    
    // Simulated seat data
    @State private var seatsData: [[SeatStatus]] = [
        [.available, .available, .available],
        [.available, .available, .available],
        [.available, .available, .available]
    ]
    
    @State private var selectedSeats: [String] = [] // Store selected seats
    @State private var timesAvailable = ["10:00 AM", "1:00 PM","3:00 PM", "4:00 PM"]
    @State private var selectedTime = "10:00 AM"
    @State private var showAlert = false // Control the display of the alert
    @State private var navigateToPersonView = false
    var body: some View {
        VStack {
            ZStack(alignment: .bottom) {
                // Display the image
                Image(image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .cornerRadius(10)
                    .padding(.top,-100)
                
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
                HStack{
                    // Display the "Time Available" section title
                    Text("Time Available:")
                        .font(.subheadline)
                        .bold()
                        .multilineTextAlignment(.leading)
                    
                    // Display a picker to select the time
                    Picker("Select Time", selection: $selectedTime) {
                        ForEach(timesAvailable, id: \.self) { time in
                            Text(time)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            
            VStack(alignment: .leading) {
                HStack{
                    // Display the "Reservate seat" section title
                    Text("Reservate seat:")
                        .font(.subheadline)
                        .bold()
                        .multilineTextAlignment(.leading)
                    
                    // Display the selected seats
                    Text(" \(selectedSeats.joined(separator: ", "))")
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            
            // Seat selection
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: seatsData[0].count), spacing: 10) {
                ForEach(0..<seatsData.count, id: \.self) { row in
                    ForEach(0..<seatsData[row].count, id: \.self) { column in
                        Button(action: {
                            // Handle seat click event
                            let seatNumber = "\(row+1)-\(column+1)"
                            if !selectedSeats.contains(seatNumber) {
                                selectedSeats.append(seatNumber)
                                seatsData[row][column] = .booked // Update seat status to booked
                            } else {
                                if let index = selectedSeats.firstIndex(of: seatNumber) {
                                    selectedSeats.remove(at: index)
                                    seatsData[row][column] = .available // Update seat status to available
                                }
                            }
                        }) {
                            VStack {
                                seatIcon(for: seatsData[row][column])
                                    .font(.system(size: 60)) // Increase seat icon size
                                    .foregroundColor(colorForSeat(row: row, column: column))
                                
                                Text("\(row+1)-\(column+1)")
                                    .font(.caption)
                                    .bold()
                                
                                // Display the seat status
                                Text(seatsData[row][column] == .booked ? "Booked" : "")
                                    .font(.caption)
                                    .foregroundColor(.red)
                                    .padding(.top, 2)
                            }
                        }
                    }
                }
            }
            
            Button(action: {
                if selectedSeats.isEmpty {
                    showAlert = true
                } else {
                    // Perform navigation to the next view
                    navigateToPersonView = true
                }
            }) {
                HStack {
                    Text("🗓️Book Now")
                        .font(.title)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.black)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding(.horizontal, 10)
            .alert(isPresented: $showAlert) {
                          Alert(
                              title: Text("Please select a seat"),
                              message: Text("You haven't selected any seat. Please select at least one seat to proceed."),
                              dismissButton: .default(Text("OK"))
                          )
                      }
            .background(
                NavigationLink(
                    destination: PersonView(seat: selectedSeats.joined(separator: ", "), time: selectedTime),
                    isActive: $navigateToPersonView) {
                    EmptyView()
                }
            )
        }
    }
    
    // Return different icons based on the seat status
    private func seatIcon(for status: SeatStatus) -> Image {
        switch status {
        case .available:
            return Image(systemName: "chair")
        case .booked:
            return Image(systemName: "chair.fill")
        }
    }
    
    // Return different colors based on the seat status
    private func colorForSeat(row: Int, column: Int) -> Color {
        return seatsData[row][column] == .available ? .green : .red
    }
    
    // Toggle the seat status
    private func toggleSeatStatus(row: Int, column: Int) {
        if seatsData[row][column] == .available {
            seatsData[row][column] = .booked
        } else {
            seatsData[row][column] = .available
        }
    }
}




struct ReservationView_Previews: PreviewProvider {
    static var previews: some View {
        ReservationView(title: "QUEFR", image: "image1")
    }
}
