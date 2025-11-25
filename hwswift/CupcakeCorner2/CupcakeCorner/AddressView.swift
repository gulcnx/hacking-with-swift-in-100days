//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by gülçin çetin on 29.08.2025.
//

import SwiftUI

struct AddressView: View {
    @Binding var order: Order
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.name)
                TextField("Street Address", text: $order.streetAddress)
                TextField("City", text: $order.city)
                TextField("Zip", text: $order.zip)
            }
            Section {
                NavigationLink("Check out") {
                    CheckoutView(order: order)
                }
            }.disabled(order.hasValidAddress == false)
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    AddressView(order: .constant(Order()))
}

