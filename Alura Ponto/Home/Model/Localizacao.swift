//
//  Localizacao.swift
//  Alura Ponto
//
//  Created by Maria Alice Rodrigues Fortunato on 23/02/22.
//

import Foundation
import CoreLocation

protocol localizacaoDelegate: AnyObject {
    func atualizaLocalizacaoUsuario(latitude: Double?, longitude: Double?)
}

class Localizacao: NSObject {
    
    private var latitude: CLLocationDegrees?
    private var longitude: CLLocationDegrees?
    
    weak var delegate: localizacaoDelegate?
    
    // pedir permissao de localizacao
    func permissao(_ gerenciadorLocalizacao: CLLocationManager) {
        gerenciadorLocalizacao.delegate = self
        gerenciadorLocalizacao.delegate = self
        // verificar se o recurso esta disponivel
        if CLLocationManager.locationServicesEnabled() {
            switch gerenciadorLocalizacao.authorizationStatus {
                // sempre           somente em uso
            case .authorizedAlways, .authorizedWhenInUse:
                gerenciadorLocalizacao.startUpdatingLocation()
                break
            case .denied:
                // alert explicando e pedindo autorizacao
                break
            case .notDetermined:
                gerenciadorLocalizacao.requestWhenInUseAuthorization() // pedir autorizacao em uso
            default:
                break
            }
        }
        
    }
}
extension Localizacao: CLLocationManagerDelegate {
    //fazer algo em relacao a autorizacao
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            manager.startUpdatingLocation() // USAR LOCALIZACAO
        default:
            break
        }
    }
    
    // quando muda de localizacao
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // latitude e longitude do usuario
        if let localizacao = locations.first {
            latitude = localizacao.coordinate.latitude
            longitude = localizacao.coordinate.longitude
        }
        delegate?.atualizaLocalizacaoUsuario(latitude: latitude, longitude: longitude)
    }
}
