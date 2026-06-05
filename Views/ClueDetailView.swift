import SwiftUI

// Vista de detalle — muestra la pista de cada ítem y permite tomar foto
struct ClueDetailView: View {
    
    let item: ScavengerItem
    var session: HuntSession
    
    // Controla si se muestra la cámara
    @State private var showCamera = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                // Nombre del negocio
                Text(item.businessName)
                    .font(.title2)
                    .bold()
                
                // Pista
                VStack(alignment: .leading, spacing: 8) {
                    Text("Your Clue:")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    Text(item.clue)
                        .font(.body)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                }
                
                // Si ya fue encontrado, muestra la foto
                if item.isFound, let photo = item.photo {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("✅ Item Found!")
                            .font(.headline)
                            .foregroundColor(.green)
                        Image(uiImage: photo)
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(12)
                    }
                } else {
                    // Botón para abrir la cámara
                    Button(action: { showCamera = true }) {
                        Label("Take Photo to Confirm", systemImage: "camera.fill")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                }
            }
            .padding()
        }
        .navigationTitle(item.name)
        .sheet(isPresented: $showCamera) {
            // Abre la vista de cámara
            CameraView { photo in
                session.markAsFound(id: item.id, photo: photo)
                showCamera = false
            }
        }
    }
}
