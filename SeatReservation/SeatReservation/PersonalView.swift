//
//  PersonalView.swift
//  SeatReservation
//
//  Created by student on 10/5/2024.
//

import SwiftUI
import SwiftData

struct PersonView: View {
    var seat: String
    var time: String
    @State private var phoneNumber = ""
    @State private var name = ""
    @State private var notes = ""
    @State private var showAlert = false
    @Environment(\.modelContext) var modelContext
    @State private var successMessage = false
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                // Display the selected seat
                Text("Seats: \(seat)")
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .bold()
                
                // Display the selected time
                Text("Time: \(time)")
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .bold()
                
                // TextField for entering phone number
                TextField("Phone Number", text: $phoneNumber)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color(.systemGray6))
                    )
                    .padding(.bottom, 10)
                    .onReceive(phoneNumber.publisher.collect()) { characters in
                        let input = String(characters)
                        let isNumeric = CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: input))
                        if !isNumeric && !input.isEmpty {
                            showAlert = true
                            phoneNumber = String(phoneNumber.dropLast())
                        }
                    }

                // TextField for entering name
                TextField("Name", text: $name)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color(.systemGray6))
                    )
                    .padding(.bottom, 10)

                // TextField for entering notes
                TextField("Notes", text: $notes)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color(.systemGray6))
                    )
                    .padding(.bottom, 10)
                
                // Button to submit the form
                Button(action: {
                    if phoneNumber.isEmpty || name.isEmpty {
                        showAlert = true
                    } else {
                        submitData(inputSeat: seat, inputTime: time, inputName: name, inputPhone: phoneNumber, inputNote: notes, inputStatus: "Booked")
                        successMessage = true
                        print("Phone Number: \(phoneNumber)")
                        print("Name: \(name)")
                        print("Notes: \(notes)")
                        print("Seats: \(seat)")
                        print("Time: \(time)")
                    }
                    
                    
                    
                    
                }) {
                    Text("🗓️Submit")
                        .font(.title)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.black)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                // Show an alert if phone number or name is empty
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Error"),
                        message: Text("Phone number and name cannot be empty."),
                        dismissButton: .default(Text("OK"))
                    )
                }
                // Show a success message after submitting the form
                .alert(isPresented: $successMessage) {
                    Alert(
                        title: Text("Success"),
                        message: Text("Your seat booked successfully."),
                        dismissButton: .default(Text("OK"))
                    )
                }
                
                Spacer()
            }
            .padding()
        }
    }

    
    // Function to submit the reservation data to the database
    private func submitData(inputSeat: String, inputTime: String, inputName: String, inputPhone: String, inputNote: String, inputStatus: String) {
        let newReservation = SeatReservationDB(seat: inputSeat, time: inputTime, name: inputName, phone: inputPhone, note: inputNote, status: inputStatus)
       
        // Insert the new reservation into the model context
        modelContext.insert(newReservation)
    }
}

#Preview {
    PersonView(seat: "1-3, 2-4", time: "11:00AM")
}
