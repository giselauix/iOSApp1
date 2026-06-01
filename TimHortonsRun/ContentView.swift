import SwiftUI

struct ContentView: View {
    
    @StateObject private var store = OrderStore()
    
    @State private var name = ""
    @State private var drink = "Coffee"
    @State private var size = "Medium"
    @State private var sugar = 1
    @State private var cream = 1
    @State private var isFavorite = false
    
    @State private var secondsRemaining = 300
    @State private var timerRunning = false
    @State private var showSaveAlert = false
    
    let drinks = ["Coffee", "Tea", "French Vanilla", "Iced Coffee", "Hot Chocolate"]
    let sizes = ["Small", "Medium", "Large", "Extra Large"]
    
    var body: some View {
        
        NavigationStack {
            
            Form {
                orderSection
                timerSection
                savedOrdersSection
            }
            .listStyle(.insetGrouped)
            .toolbar {
                
                // Tim Hortons Logo + Title
                ToolbarItem(placement: .principal) {
                    
                    HStack(spacing: 10) {
                        
                        Image("TimLogo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 36, height: 36)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                        
                        Text("Tim Hortons Run")
                            .font(.title2)
                            .fontWeight(.bold)
                    }
                }
                
                // Cart Button
                ToolbarItem(placement: .topBarTrailing) {
                    
                    NavigationLink {
                        CartView(orders: store.orders)
                    } label: {
                        
                        Image(systemName: "cart.fill")
                            .font(.title2)
                            .foregroundStyle(.red)
                    }
                }
            }
        }
        .tint(.red)
    }
}

// MARK: - Sections

extension ContentView {
    
    private var orderSection: some View {
        Section("Create Order") {
            TextField("Team member name", text: $name)
            
            Picker("Drink", selection: $drink) {
                ForEach(drinks, id: \.self) {
                    Text($0)
                }
            }
            
            Picker("Size", selection: $size) {
                ForEach(sizes, id: \.self) {
                    Text($0)
                }
            }
            
            Stepper("Sugar: \(sugar)", value: $sugar, in: 0...5)
            Stepper("Cream: \(cream)", value: $cream, in: 0...5)
            
            Toggle("Favourite Order", isOn: $isFavorite)
            
            Button("Save Order") {
                saveOrder()
                showSaveAlert = true
            }
            .disabled(name.trimmingCharacters(in: .whitespaces).isEmpty)
            .alert("Order Saved Successfully!", isPresented: $showSaveAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text("The Tim Hortons order was added to the saved orders list.")
            }
        }
    }
    
    private var timerSection: some View {
        Section("Coffee Run Timer") {
            Text(timeString)
                .font(.headline)
            
            Button(timerRunning ? "Timer Running..." : "Start Timer") {
                startTimer()
            }
            .disabled(timerRunning)
        }
    }
    
    private var savedOrdersSection: some View {
        Section("Saved Orders") {
            if store.orders.isEmpty {
                Text("No saved orders yet.")
                    .foregroundStyle(.secondary)
            } else {
                ForEach(store.orders) { order in
                    OrderRow(order: order)
                }
                .onDelete(perform: store.deleteOrder)
            }
        }
    }
}

// MARK: - Functions

extension ContentView {
    
    private var timeString: String {
        let minutes = secondsRemaining / 60
        let seconds = secondsRemaining % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    // Saves a new order and clears the form.
    private func saveOrder() {
        let order = Order(
            name: name,
            drink: drink,
            size: size,
            sugar: sugar,
            cream: cream,
            isFavorite: isFavorite
        )
        
        store.addOrder(order)
        resetForm()
    }
    
    // Resets form values after saving.
    private func resetForm() {
        name = ""
        drink = "Coffee"
        size = "Medium"
        sugar = 1
        cream = 1
        isFavorite = false
    }
    
    // Starts a 5-minute coffee run timer.
    private func startTimer() {
        timerRunning = true
        secondsRemaining = 300
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if secondsRemaining > 0 {
                secondsRemaining -= 1
            } else {
                timer.invalidate()
                timerRunning = false
            }
        }
    }
}
