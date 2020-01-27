//
//  CoreDataUserRepository.swift
//  GeekbrainsUI
//
//  Created by raskin-sa on 21/01/2020.
//  Copyright © 2020 raskin-sa. All rights reserved.
//

import Foundation
import CoreData

class CoreDataUserRepository {
    var context: NSManagedObjectContext
    
    init(stack: CoreDataStack){
        context = stack.context
    }
    
    func query(with predicate: NSPredicate?) -> [UserCD]{
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserCD")
        fetchRequest.predicate = predicate
        
        do {
            let result = try context.fetch(fetchRequest)
            return result as! [UserCD]
        } catch {
            return []
        }
    }
    
    func find (id:Int) -> UserCD? {
        query(with: NSPredicate(format:"id == %@ AND username == %@","\(id)","Alex")).first
    }
}//
