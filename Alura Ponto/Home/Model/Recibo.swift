//
//  Recibo.swift
//  Alura Ponto
//
//  Created by Ândriu Felipe Coelho on 29/09/21.
//

import Foundation
import UIKit
import CoreData

@objc(Recibo)
class Recibo: NSManagedObject {
    
    @NSManaged var id: UUID
    @NSManaged var status: Bool
    @NSManaged var data: Date
    @NSManaged var foto: UIImage
    
    convenience init(status: Bool, data: Date, foto: UIImage) {
        let contexto = UIApplication.shared.delegate as! AppDelegate
        self.init(context: contexto.persistentContainer.viewContext)
        self.id = UUID()
        self.status = status
        self.data = data
        self.foto = foto
    }
}
extension Recibo {
    
    // MARK: -  Core Data - DAO
    class func fetchRequest() -> NSFetchRequest<Recibo> {
        return NSFetchRequest(entityName: "Recibo")
    }
    // salvar foto
    func salvar(_ contexto: NSManagedObjectContext) {
        do {
            try contexto.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    // nao precisa instanciar a classe para usar esse metodo
                                                // recuperar infos salvas 
    class func carregar(_ fetchResultController: NSFetchedResultsController<Recibo>) {
        do {
            try fetchResultController.performFetch() // variavel que faz a busca
        } catch {
            print(error.localizedDescription)
        }
        
    }
    // deletar recibo
    func deletar(_ contexto: NSManagedObjectContext) {
        contexto.delete(self) // deletar
        
        do { // salvar a operacao 
            try contexto.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}
