//
//  FriendRepository.swift
//  GeekbrainsUI
//
//  Created by raskin-sa on 24/01/2020.
//  Copyright © 2020 raskin-sa. All rights reserved.
//


import CoreData

protocol Repository {
    associatedtype Entity
    
    func getAll() -> [Entity]
    func get(id:Int) -> Entity?
}
class FriendCoreDataRepository {
    typealias Entity = VKUser
    
let context: NSManagedObjectContext

init(stack: CoreDataStack){
    self.context = stack.context
}
    
    private func queryCD(with predicate: NSPredicate?, sortDescriptors:[NSSortDescriptor]?=nil)->[FriendCD]{
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FriendCD")
        fetchRequest.predicate = predicate
        do{
            return try (context.fetch(fetchRequest) as? [FriendCD] ?? [])
        }catch{
            return []
        }
    }//private func queryCD
    
   private func query(with predicate: NSPredicate?, sortDescriptors:[NSSortDescriptor]?=nil)->[VKUser]{
       let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FriendCD")
       fetchRequest.predicate = predicate
       do{
           let objects = try (context.fetch(fetchRequest)) as? [FriendCD]
        return objects?.map{$0.toCommonItem() } ?? []
       }catch{
           return []
       }
   }//private func query

func getAll() -> [VKUser]{
    return query(with: nil, sortDescriptors: [NSSortDescriptor(key: "id", ascending: true)])
}

func get(id: Int) -> VKUser? {
    return query(with: NSPredicate(format: "id = %@","\(id)" )).first
}
    
    func create(entity: VKUser) -> Bool {
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "FriendCD", in: context) else {return false}
        
        let friendEntity = NSManagedObject(entity: entityDescription, insertInto: context)
//        friendEntity.setValue(<#T##value: Any?##Any?#>, forKey: <#T##String#>)
//        friendEntity.setValue(<#T##value: Any?##Any?#>, forKey: <#T##String#>)
//        friendEntity.setValue(<#T##value: Any?##Any?#>, forKey: <#T##String#>)
//        friendEntity.setValue(<#T##value: Any?##Any?#>, forKey: <#T##String#>)
//        friendEntity.setValue(<#T##value: Any?##Any?#>, forKey: <#T##String#>)
//        friendEntity.setValue(<#T##value: Any?##Any?#>, forKey: <#T##String#>)
        return save()
    }//func create
    
    private func save() -> Bool{
        do {
            try context.save()
            return true
        }catch{
            return false
        }
    }
}//class FriendRepository
