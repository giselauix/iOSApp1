import Foundation

// Represents one Tim Hortons order.
struct Order: Identifiable, Codable {
    var id = UUID()
    var name: String
    var drink: String
    var size: String
    var sugar: Int
    var cream: Int
    var isFavorite: Bool
}
