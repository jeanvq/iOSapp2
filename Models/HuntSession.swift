import Foundation
import SwiftUI

// @Observable permite compartir el estado entre todas las vistas
@Observable
class HuntSession {

    var items: [ScavengerItem] = ScavengerItem.allItems
    
    // Cuenta cuántos ítems fueron encontrados
    var foundCount: Int {
        items.filter { $0.isFound }.count
    }
    
    // Verifica si todos fueron encontrados
    var allFound: Bool {
        foundCount == items.count
    }
    
    // Descuento según ítems encontrados
    var discountCode: String? {
        if foundCount >= 10 { return "HUNT100-GRAND" }
        if foundCount >= 7  { return "HUNT20-OFF" }
        if foundCount >= 5  { return "HUNT10-OFF" }
        return nil
    }
    
    // Marca un ítem como encontrado con su foto
    func markAsFound(id: UUID, photo: UIImage) {
        if let index = items.firstIndex(where: { $0.id == id }) {
            items[index].isFound = true
            items[index].photo = photo
        }
    }

    // MARK: - Demo Mode
    // Simula encontrar ítems para propósitos de demostración
    func simulateFound(_ count: Int) {
        // Crea una imagen de placeholder para simular las fotos
        let demoImage = UIImage(systemName: "photo.fill") ?? UIImage()

        // Marca los primeros 'count' ítems como encontrados
        for i in 0..<min(count, items.count) {
            items[i].isFound = true
            items[i].photo = demoImage
        }
    }

    // Resetea todos los ítems al estado inicial
    func resetHunt() {
        items = ScavengerItem.allItems
    }
}
