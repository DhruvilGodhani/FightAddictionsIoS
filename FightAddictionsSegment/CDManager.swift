//
//  CDManager.swift
//  Cd-Segment-GU
//
//  Created by Jaimin Raval on 03/12/24.
//

import UIKit
import CoreData

class CDManager {
    
    func readFromCd() -> [QuoteModel] {
        
        var quoteArr: [QuoteModel] = []
        
        let delegate = UIApplication.shared.delegate as? AppDelegate

        let managedContext = delegate!.persistentContainer.viewContext
        
        let fetchRes = NSFetchRequest<NSFetchRequestResult>(entityName: "Quotes")
        
        do {
            let dataArr = try managedContext.fetch(fetchRes)
            
            for d in dataArr as! [NSManagedObject] {
                let quote = d.value(forKey: "quote") as! String
                let id = d.value(forKey: "id") as! Int64
                quoteArr.append(QuoteModel(id: id, quote: quote))
//                print("name: \(quote)")
            }
            
        } catch let err as NSError {
            print(err)
        }
        return quoteArr
    }
    
    
    func AddToCd(quoteToAdd: QuoteModel) {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = delegate.persistentContainer.viewContext
        
        guard let quoteEnt = NSEntityDescription.entity(forEntityName: "Quotes", in: managedContext) else { return }
        
        let quote = NSManagedObject(entity: quoteEnt, insertInto: managedContext)
        quote.setValue(quoteToAdd.quote, forKey: "quote")
        
        do {
            try managedContext.save()
            print("quote Saved successfully!")
        } catch let err as NSError {
            print(err)
        }
    }
    
    
    //  delete func for CD
    func deleteFromCD(quote: QuoteModel) {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = delegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Quotes")
        
        fetchRequest.predicate = NSPredicate(format: "name = %@", quote.quote)
//        fetchRequest.predicate = NSPredicate(format: "id = %@", quote.quoteid)
        
        do {
            let fetchRes = try managedContext.fetch(fetchRequest)
            let objToDelete = fetchRes[0] as! NSManagedObject
            managedContext.delete(objToDelete)
            
            try managedContext.save()
            print("quote deleted successfully")
            
        } catch let err as NSError {
            print("Somthing went wrong while deleting \(err)")
        }
    }
    
    
    
}
