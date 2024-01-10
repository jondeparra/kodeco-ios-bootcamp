//
//  UserDetails.swift
//  JSONReader
//
//  Created by Jonathan Parra on 1/10/24.
//

import SwiftUI

struct UserDetails: View {
    var user: User = .example

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                HStack(spacing: 12) {
                    if let imageUrl = URL(string: user.picture.large) {
                        AsyncImage(url: imageUrl) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 64, height: 64)
                        .clipShape(Circle())
                    }

                    VStack(alignment: .leading) {
                        Text(user.name.first + " " + user.name.last)
                            .fontWeight(.semibold)
                        Text(user.email)
                            .font(.subheadline)
                    }
                }

                VStack(alignment: .leading, spacing: 8) {
                    Text("Details:")
                        .fontWeight(.semibold)
                    Text("Gender: \(user.gender.capitalized)")
                    Text("Phone: \(user.phone)")
                    Text("Cell: \(user.cell)")
                    Text("Nationality: \(user.nat)")
                    Text("Age: \(user.dob.age)")
                    Group {
                        let dateString = user.dob.date
                        let formattedDate = formatDate(dateString)
                        Text("Date of Birth: \(formattedDate)")
                    }
                }

                Divider()

                VStack(alignment: .leading, spacing: 8) {
                    Text("Location:")
                        .fontWeight(.semibold)
                    Text("Street: \(user.location.street.name) \(user.location.street.number)")
                    Text("City: \(user.location.city)")
                    Text("State: \(user.location.state)")
                    Text("Country: \(user.location.country)")
                    Text("Postcode: \(user.location.postcode)")
                }
            }
            .padding(.horizontal, 16)
        }
    }

    func formatDate(_ dateString: String) -> String {
        let inputFormatter = ISO8601DateFormatter()
        inputFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

        if let date = inputFormatter.date(from: dateString) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "MMMM dd, yyyy"
            return outputFormatter.string(from: date)
        } else {
            return "Invalid date"
        }
    }
}

#Preview {
    UserDetails()
}
