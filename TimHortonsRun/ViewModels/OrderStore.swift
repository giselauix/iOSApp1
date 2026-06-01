import SwiftUI
import Combine

// Manages saving, loading, adding, and deleting orders.
class OrderStore: ObservableObject {
    
    @Published var orders: [Order] = [] {
        didSet {
            saveOrders()
        }
    }
    
    private let saveKey = "savedTimHortonsOrders"
    
    init() {
        loadOrders()
    }
    
    // Adds a new order to the saved list.
    func addOrder(_ order: Order) {
        orders.append(order)
    }
    
    // Deletes selected orders from the saved list.
    func deleteOrder(at offsets: IndexSet) {
        for index in offsets {
            orders.remove(at: index)
        }
    }
    
    // Saves orders as JSON using UserDefaults.
    private func saveOrders() {
        if let encoded = try? JSONEncoder().encode(orders) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }
    
    // Loads saved orders when the app opens.
    private func loadOrders() {
        guard let data = UserDefaults.standard.data(forKey: saveKey) else {
            return
        }
        
        if let decoded = try? JSONDecoder().decode([Order].self, from: data) {
            orders = decoded
        }
    }
}
