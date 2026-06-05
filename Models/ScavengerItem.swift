import SwiftUI

// Modelo que representa cada ítem del scavenger hunt
struct ScavengerItem: Identifiable {
    let id = UUID()
    let name: String          // Nombre del ítem
    let clue: String          // Pista para encontrarlo
    let businessName: String  // Negocio local donde está escondido
    var isFound: Bool = false // Si fue encontrado por el usuario
    var photo: UIImage? = nil // Foto tomada como evidencia
}

// Extensión con los 10 ítems predefinidos del hunt
extension ScavengerItem {
    static let allItems: [ScavengerItem] = [
        ScavengerItem(name: "Golden Fork",
                      clue: "Where pasta dreams come true on King Street.",
                      businessName: "Marcello's Italian Kitchen"),
        ScavengerItem(name: "Red Bookmark",
                      clue: "Between shelves of mystery novels downtown.",
                      businessName: "Words & Co. Bookstore"),
        ScavengerItem(name: "Movie Ticket Stub",
                      clue: "Near the popcorn machine at the main cinema.",
                      businessName: "Waterloo Cinemas"),
        ScavengerItem(name: "Blue Coffee Cup",
                      clue: "Hidden near the espresso bar on Erb Street.",
                      businessName: "Groundwork Coffee"),
        ScavengerItem(name: "Mini Trophy",
                      clue: "Where athletes shop for their gear.",
                      businessName: "Champion Sports"),
        ScavengerItem(name: "Vintage Coin",
                      clue: "Ask the jeweler — it's older than it looks.",
                      businessName: "Heritage Jewellers"),
        ScavengerItem(name: "Green Keychain",
                      clue: "Hanging near the front entrance of the plant shop.",
                      businessName: "Bloom & Grow"),
        ScavengerItem(name: "Recipe Card",
                      clue: "Next to the fresh bread at the local bakery.",
                      businessName: "The Daily Loaf"),
        ScavengerItem(name: "Wooden Spoon",
                      clue: "Where local chefs shop for ingredients.",
                      businessName: "Waterloo Market"),
        ScavengerItem(name: "Chamber Seal",
                      clue: "The final prize — find it at the Chamber of Commerce itself.",
                      businessName: "Waterloo Chamber of Commerce")
    ]
}
