//
//  MapaViewController.swift
//  Alura Ponto
//
//  Created by Maria Alice Rodrigues Fortunato on 23/02/22.
//

import UIKit
import MapKit  // localizaçao

class MapaViewController: UIViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet weak var mapa: MKMapView!
    
    // MARK: - Atributos
    
    private var recibo: Recibo?
    
    // MARK: - Instanciar
    
    class func instanciar(_ recibo: Recibo?) -> MapaViewController {
                                                // nome do  xib,          mesmo pacote 
        let controller = MapaViewController(nibName: "MapaViewController", bundle: nil)
        controller.recibo = recibo
        
        return controller
    }
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setRegiao()
        adicionarPino()

    }
    
    // MARK: - Métodos

    func setRegiao() {
        
        guard let latitude = recibo?.latitude, let longitude = recibo?.longitude else {return}
        
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        
        // regiao q vai exibir no mapa
        let regiao = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
        
        mapa.setRegion(regiao, animated: true)
        
    }
    func adicionarPino() {
        
        let annotation = MKPointAnnotation()
        annotation.title = "Registro de ponto"
        
        annotation.coordinate.latitude = recibo?.latitude ?? 0.0
        annotation.coordinate.latitude = recibo?.longitude ?? 0.0
        
        mapa.addAnnotation(annotation)  // adicionar no mapa
          
    }
    
}


// Teste - Descobrir latitude e longitude a partir da localizacao(nome)
//
//let geoCoder = CLGeocoder()
//
//geoCoder.geocodeAddressString("Avenida Paulista") { locaisEncontrados, error in
//    let localizacao = locaisEncontrados?.first
//
//    let latitude = localizacao?.location?.coordinate.latitude
//    let longitude = localizacao?.location?.coordinate.longitude
//
//}
