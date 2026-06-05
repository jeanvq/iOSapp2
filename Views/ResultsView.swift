import SwiftUI

// Vista final — muestra el resumen del hunt y el descuento ganado
struct ResultsView: View {
    
    var session: HuntSession
    
    // Controla si se muestra la alerta de confirmación
    @State private var showSubmitAlert = false
    // Controla si ya se hizo el submit
    @State private var submitted = false
    
    var body: some View {
        ZStack {
            // Fondo oscuro igual que ContentView
            LinearGradient(
                colors: [Color(hex: "0f0c29"), Color(hex: "302b63"), Color(hex: "24243e")],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 24) {
                    
                    // Título
                    Text("Your Results 🏆")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)
                    
                    // Contador de ítems encontrados
                    Text("\(session.foundCount) out of \(session.items.count) items found")
                        .font(.title2)
                        .foregroundColor(.white.opacity(0.7))
                    
                    // Barra de progreso
                    ProgressView(value: Double(session.foundCount), total: Double(session.items.count))
                        .tint(.purple)
                        .padding(.horizontal)
                    
                    Divider().overlay(Color.white.opacity(0.2))
                    
                    // Mensaje según el resultado
                    if let code = session.discountCode {
                        VStack(spacing: 12) {
                            
                            if session.foundCount == 10 {
                                Text("🎉 Amazing! You found them all!")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                Text("You've been entered into the $5,000 grand prize draw!")
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.purple)
                            } else if session.foundCount >= 7 {
                                Text("🌟 Great job!")
                                    .font(.headline)
                                    .foregroundColor(.white)
                            } else {
                                Text("👍 Good effort!")
                                    .font(.headline)
                                    .foregroundColor(.white)
                            }
                            
                            // Código de descuento
                            Text("Your discount code:")
                                .foregroundColor(.white.opacity(0.6))
                            
                            Text(code)
                                .font(.title)
                                .bold()
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.white.opacity(0.1))
                                .cornerRadius(12)
                            
                            // Porcentaje del descuento
                            Text(session.foundCount >= 7 ? "20% OFF your next purchase!" : "10% OFF your next purchase!")
                                .foregroundColor(.green)
                                .font(.headline)
                        }
                    } else {
                        // Menos de 5 ítems encontrados
                        VStack(spacing: 8) {
                            Text("😕 Not enough items found")
                                .font(.headline)
                                .foregroundColor(.white)
                            Text("Find at least 5 items to earn a discount code.")
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white.opacity(0.6))
                        }
                    }
                    
                    Divider().overlay(Color.white.opacity(0.2))
                    
                    // Lista de ítems con su estado
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Item Summary")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        ForEach(session.items) { item in
                            HStack {
                                Image(systemName: item.isFound ? "checkmark.circle.fill" : "xmark.circle")
                                    .foregroundColor(item.isFound ? .green : .red)
                                Text(item.name)
                                    .foregroundColor(.white)
                                Spacer()
                                Text(item.businessName)
                                    .font(.caption)
                                    .foregroundColor(.white.opacity(0.5))
                            }
                        }
                    }
                    .padding()
                    .background(Color.white.opacity(0.07))
                    .cornerRadius(16)
                    
                    // Botón de Submit
                    if !submitted {
                        Button(action: {
                            // Muestra alerta de confirmación antes de enviar
                            showSubmitAlert = true
                        }) {
                            Label("Submit My Results", systemImage: "paperplane.fill")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(session.foundCount >= 5 ? Color.purple : Color.gray)
                                .foregroundColor(.white)
                                .cornerRadius(14)
                                .bold()
                        }
                        .disabled(session.foundCount == 0)
                        
                        if session.foundCount == 0 {
                            Text("Find at least 1 item to submit.")
                                .font(.caption)
                                .foregroundColor(.white.opacity(0.4))
                        }
                        
                    } else {
                        // Confirmación de envío exitoso
                        VStack(spacing: 8) {
                            Image(systemName: "checkmark.seal.fill")
                                .font(.system(size: 48))
                                .foregroundColor(.green)
                            Text("Results Submitted!")
                                .font(.headline)
                                .foregroundColor(.white)
                            Text("The Chamber of Commerce will contact you shortly.")
                                .font(.caption)
                                .foregroundColor(.white.opacity(0.6))
                                .multilineTextAlignment(.center)
                        }
                        .padding()
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Results")
        .toolbarBackground(.hidden, for: .navigationBar)
        // Alerta de confirmación antes de enviar
        .alert("Submit Results?", isPresented: $showSubmitAlert) {
            Button("Cancel", role: .cancel) {}
            Button("Submit") {
                // Simula el envío online
                submitted = true
            }
        } message: {
            Text("You found \(session.foundCount) out of \(session.items.count) items. Ready to submit?")
        }
    }
}
