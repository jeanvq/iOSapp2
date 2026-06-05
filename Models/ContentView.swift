import SwiftUI

struct ContentView: View {
    
    @State var session = HuntSession()
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Fondo oscuro degradado
                LinearGradient(
                    colors: [Color(hex: "0f0c29"), Color(hex: "302b63"), Color(hex: "24243e")],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    
                    // Header
                    VStack(spacing: 6) {
                        Text("🗺️ Scavenger Hunt")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(.white)
                        
                        Text("\(session.foundCount) of \(session.items.count) items found")
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.7))
                        
                        // Barra de progreso
                        ProgressView(value: Double(session.foundCount), total: Double(session.items.count))
                            .tint(.purple)
                            .padding(.horizontal)
                            .padding(.top, 4)
                    }
                    .padding()
                    
                    // Lista de ítems
                    ScrollView {
                        VStack(spacing: 12) {
                            ForEach(session.items) { item in
                                NavigationLink(destination: ClueDetailView(item: item, session: session)) {
                                    ItemRow(item: item)
                                }
                            }
                        }
                        .padding(.horizontal)
                        .padding(.bottom)
                    }
                }
            }
            .toolbar {
                // Botón de demo mode en el toolbar izquierdo
                ToolbarItem(placement: .navigationBarLeading) {
                    Menu("🎮 Demo") {
                        Button("Find 5 items (10% off)") { session.simulateFound(5) }
                        Button("Find 7 items (20% off)") { session.simulateFound(7) }
                        Button("Find ALL items ($5000 draw)") { session.simulateFound(10) }
                        Divider()
                        Button("Reset Hunt", role: .destructive) { session.resetHunt() }
                    }
                    .foregroundColor(.purple)
                }
                
                // Botón de resultados en el toolbar derecho
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: ResultsView(session: session)) {
                        Text("Results")
                            .bold()
                            .foregroundColor(.purple)
                    }
                }
            }
            .toolbarBackground(.hidden, for: .navigationBar)
        }
        .preferredColorScheme(.dark)
    }
}

private struct ItemRow: View {
    let item: ScavengerItem

    var body: some View {
        HStack(spacing: 16) {
            statusIcon

            VStack(alignment: .leading, spacing: 4) {
                Text(item.name)
                    .font(.headline)
                    .foregroundColor(.white)
                Text(item.businessName)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.5))
            }

            Spacer()

            Image(systemName: "chevron.right")
                .foregroundColor(.white.opacity(0.3))
                .font(.caption)
        }
        .padding()
        .background(rowBackground)
    }

    private var statusIcon: some View {
        ZStack {
            Circle()
                .fill(item.isFound ? Color.purple : Color.white.opacity(0.1))
                .frame(width: 44, height: 44)
            Image(systemName: item.isFound ? "checkmark" : "magnifyingglass")
                .foregroundColor(item.isFound ? .white : .gray)
                .font(.system(size: 18, weight: .bold))
        }
    }

    private var rowBackground: some View {
        RoundedRectangle(cornerRadius: 16)
            .fill(Color.white.opacity(0.07))
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(item.isFound ? Color.purple.opacity(0.6) : Color.clear, lineWidth: 1)
            )
    }
}

// Extension para usar colores hex en SwiftUI
extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        let r = Double((rgb >> 16) & 0xFF) / 255
        let g = Double((rgb >> 8) & 0xFF) / 255
        let b = Double(rgb & 0xFF) / 255
        self.init(red: r, green: g, blue: b)
    }
}
