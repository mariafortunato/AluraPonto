//
//  Autenticacao.swift
//  Alura Ponto
//
//  Created by Maria Alice Rodrigues Fortunato on 23/02/22.
//

import Foundation
import LocalAuthentication

class AutenticacaoLocal {
    // gerenciador de autenticacao              
    private let authenticatiorContext = LAContext()
    private var error: NSError?
    
    func autorizaUsuario(completion: @escaping(_ autenticacao: Bool) -> Void)  {
    
        // verificar se tem essa opcao de autenticacao    - biometria ou autenticacao
        if authenticatiorContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error ) {
            authenticatiorContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Necessário autenticação para apagar o recibo") {sucesso, error in
                
                completion(sucesso)
            }
        }
    }
}
