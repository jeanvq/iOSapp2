import SwiftUI
import UIKit

// Vista de cámara — usa UIImagePickerController para tomar la foto
struct CameraView: UIViewControllerRepresentable {
    
    // Callback que regresa la foto tomada a ClueDetailView
    var onPhotoTaken: (UIImage) -> Void
    
    // Coordinator maneja los eventos del picker
    func makeCoordinator() -> Coordinator {
        Coordinator(onPhotoTaken: onPhotoTaken)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        
        // Usa la cámara si está disponible, si no usa la galería (para el simulador)
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    // Coordinator actúa como delegate del picker
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        var onPhotoTaken: (UIImage) -> Void
        
        init(onPhotoTaken: @escaping (UIImage) -> Void) {
            self.onPhotoTaken = onPhotoTaken
        }
        
        // Se llama cuando el usuario toma o selecciona una foto
        func imagePickerController(_ picker: UIImagePickerController,
                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let image = info[.originalImage] as? UIImage {
                onPhotoTaken(image)
            }
            picker.dismiss(animated: true)
        }
        
        // Se llama si el usuario cancela
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }
    }
}
