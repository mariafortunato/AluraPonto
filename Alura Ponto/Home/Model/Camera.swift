//
//  Camera.swift
//  Alura Ponto
//
//  Created by Maria Alice Rodrigues Fortunato on 22/02/22.
//

import Foundation
import UIKit

protocol CameraDelegate: AnyObject {
    //acabou de selecionar a foto e devolve uiImage
    func didSelectFoto(_ image: UIImage)
}

class Camera: NSObject {
    
    weak var delegate: CameraDelegate?
    
    func abrirCamera(_ controller: UIViewController, _ imagePicker: UIImagePickerController){
        imagePicker.delegate = self // essa classe q implementa o delegate
        imagePicker.allowsEditing = true //editar foto
        imagePicker.sourceType = .camera // abrir camera
        // verificar se tem camera frontal, caso nao tenha usar a traseira mesmo
        imagePicker.cameraDevice = UIImagePickerController.isCameraDeviceAvailable(.front) ? .front : . rear
        
        controller.present(imagePicker, animated: true, completion: nil)
    }
    // chamar biblioteca (controller recebendo como parametro)
    func abrirBiblioteca(_ controller: UIViewController, _ imagePicker: UIImagePickerController) {
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        
        controller.present(imagePicker, animated: true, completion: nil)
    }
}
extension Camera: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    // usar a foto
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true) // fechar o picker
        
        // se conseguir fazer isso, ja tem acesso a foto e recupera ela
        guard let foto = info[.editedImage] as? UIImage else { return }
        
        delegate?.didSelectFoto(foto)
    }
    
}
