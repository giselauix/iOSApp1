import SwiftUI

// Displays one saved order in a clean row design.
struct OrderRow: View {
    
    let order: Order
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: order.isFavorite ? "star.fill" : "cup.and.saucer.fill")
                .foregroundStyle(order.isFavorite ? .yellow : .red)
                .font(.title2)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(order.name)
                    .font(.headline)
                
                Text("\(order.size) \(order.drink)")
                
                Text("Sugar: \(order.sugar) | Cream: \(order.cream)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.vertical, 4)
    }
}
