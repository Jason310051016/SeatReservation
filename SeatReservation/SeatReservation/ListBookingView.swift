//
//  ListBookingView.swift
//  SeatReservation
//
//  Created by student on 10/5/2024.
//

import SwiftUI
import SwiftData

struct ListBookingView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [SeatReservationDB]
    @State private var showAlert = false
    @State private var selectedItem: SeatReservationDB?

    var body: some View {
        // List view to display the reservations
        List {
            // Iterate over the items and filter the ones with status "Booked"
            ForEach(items.filter { $0.status == "Booked" }) { item in
                VStack(alignment: .leading) {
                    HStack {
                        VStack {
                            // Display the name
                            Text("Name: \(item.name)")
                                .font(.headline)
                                .foregroundColor(.black)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)

                            // Display the phone number
                            Text("Phone: \(item.phone)")
                                .font(.headline)
                                .foregroundColor(.black)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)

                            // Display the seat number
                            Text("Seat: \(item.seat)")
                                .font(.headline)
                                .foregroundColor(.black)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            
                            // Display the reservation time
                            Text("Time: \(item.time)")
                                .font(.headline)
                                .foregroundColor(.black)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                           
                            // Display any additional notes
                            Text("Note: \(item.note)")
                                .font(.headline)
                                .foregroundColor(.black)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            
                        }
                        
                        // Button to cancel the reservation
                        Button(action: {
                            self.showAlert = true
                            self.selectedItem = item
                        }) {
                            Text("Cancel")
                        }
                    }
                }
                .padding()
                .cornerRadius(10)
                .shadow(color: Color.gray.opacity(0.4), radius: 3, x: 0, y: 2)
                .padding(.vertical, 4)
            }
        }
        .navigationTitle("Booked List")
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Delete Record"),
                message: Text("Are you sure you want to cancel this reservation?"),
                primaryButton: .destructive(Text("Cancel Reservation")) {
                    if let item = self.selectedItem {
                        deleteRecord(item: item)
                    }
                },
                secondaryButton: .cancel()
            )
        }
    }

    // Function to cancel a reservation
    func deleteRecord(item: SeatReservationDB) {
        // Set the status of the reservation to "Cancel"
        item.status = "Cancel"

        do {
            // Save the changes to the model context
            try modelContext.save()
            print("Reservation for seat \(item.seat) cancelled successfully.")
        } catch {
            print("Error cancelling reservation: \(error)")
        }
    }
}


struct ListBookingView_Previews: PreviewProvider {
    static var previews: some View {
        ListBookingView()
            .modelContainer(for: SeatReservationDB.self, inMemory: true)
    }
}
