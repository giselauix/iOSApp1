import SwiftUI

// Shows all saved orders before the coffee run is completed.
struct CartView: View {
    
    let orders: [Order]
    
    var body: some View {
        List {
            Section("Order Confirmation") {
                if orders.isEmpty {
                    Text("No orders to confirm.")
                        .foregroundStyle(.secondary)
                } else {
                    ForEach(orders) { order in
                        OrderRow(order: order)
                    }
                }
            }
            
            Section("Summary") {
                Text("Total Orders: \(orders.count)")
                Text("Ready for Tim Hortons pickup.")
            }
        }
        .navigationTitle("Cart")
    }
}
