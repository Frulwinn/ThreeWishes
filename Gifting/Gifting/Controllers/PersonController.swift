//
//  PersonController.swift
//  Gifting
//
//  Created by Lambda_School_Loaner_34 on 3/18/19.
//  Copyright © 2019 Frulwinn. All rights reserved.
//

import Foundation
import CoreData

class PersonController {
    
    init() {
        fetchPersonFromServer()
    }
    
    let baseURL = URL(string: "https://gifting-437b5.firebaseio.com/")!
    
    //create
    func createPerson(with name: String, birthday: Date, firstChoice: String?, secondChoice: String?, thirdChoice: String?, isBoughtFirst: Bool?, isBoughtSecond: Bool?, isBoughtThird: Bool?) -> Person {
        let person = Person(name: name, birthday: birthday, firstChoice: firstChoice, secondChoice: secondChoice, thirdChoice: thirdChoice, isBoughtFirst: isBoughtFirst ?? false, isBoughtSecond: isBoughtSecond ?? false, isBoughtThird: isBoughtThird ?? false)
        
        saveToPersistentStore()
        put(person)
        return person
    }
    
    //update
    func update(_ person: Person, withName name: String, birthday: Date, firstChoice: String?, secondChoice: String?, thirdChoice: String?, isBoughtFirst: Bool?, isBoughtSecond: Bool?, isBoughtThird: Bool?) {
        person.name = name
        person.birthday = birthday
        person.firstChoice = firstChoice
        person.secondChoice = secondChoice
        person.thirdChoice = thirdChoice
        person.isBoughtFirst = isBoughtFirst ?? false
        person.isBoughtSecond = isBoughtSecond ?? false
        person.isBoughtThird = isBoughtThird ?? false

        put(person)
        saveToPersistentStore()
    }
    
    func updateWithPersonRepresentation(_ person: Person, personRepresentation: PersonRepresentation) {
        person.name = personRepresentation.name
        person.birthday = personRepresentation.birthday
        person.firstChoice = personRepresentation.firstChoice
        person.secondChoice = personRepresentation.secondChoice
        person.thirdChoice = personRepresentation.thirdChoice
        person.identifier = personRepresentation.identifier
        person.isBoughtFirst = personRepresentation.isBoughtFirst ?? false
        person.isBoughtSecond = personRepresentation.isBoughtSecond ?? false
        person.isBoughtThird = personRepresentation.isBoughtThird ?? false

    }
    
    
    //save
    func saveToPersistentStore(context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        
        do {
            try context.save()
        } catch {
            NSLog("Error saving managed object context: \(error)")
        }
    }
    
    //put
    func put(_ person: Person, completion: @escaping (Error?) -> Void = { _ in }) {
        let identifier = person.identifier ?? UUID().uuidString
        
        let url = baseURL.appendingPathComponent(identifier).appendingPathExtension("json")
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        
        let encoder = JSONEncoder()
        
        do {
            let taskJSON = try encoder.encode(person)
            request.httpBody = taskJSON
            saveToPersistentStore()
        } catch {
            NSLog("unable to encode person representation: \(error)")
            completion(error)
        }
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error putting person to server: \(error)")
                completion(error)
                return
            }
            completion(nil)
        }.resume()
    }
    
    //fetch
    func fetchOnePersonFromServer(identifier: String, context: NSManagedObjectContext) -> Person? {
        let fetchRequest: NSFetchRequest<Person> = Person.fetchRequest()
        
        fetchRequest.predicate = NSPredicate(format: "identifier == %@", identifier)
        
        var person: Person?
        context.performAndWait {
            do {
                person = try context.fetch(fetchRequest).first
            } catch {
                NSLog("Error fetching person with \(identifier): \(error)")
            }
        }
        return person
    }
    
    func fetchPersonFromServer(completion: @escaping (Error?) -> Void = { _ in }) {
        
        let url = baseURL.appendingPathExtension("json")
        let urlRequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching person: \(error)")
                completion(error)
                return
            }
            
            guard let data = data else {
                NSLog("No data returned from data task")
                completion(NSError())
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                let personRepresentations = try jsonDecoder.decode([String: PersonRepresentation].self, from: data)
                let backgroundMoc = CoreDataStack.shared.container.newBackgroundContext()
                
                backgroundMoc.performAndWait {
                    for (_, personRep) in personRepresentations {
                        
                        if let person = self.fetchOnePersonFromServer(identifier: personRep.identifier, context: backgroundMoc) {
                            self.updateWithPersonRepresentation(person, personRepresentation: personRep)
                            
                        } else {
                            let _ = Person(personRepresentation: personRep, context: backgroundMoc)
//                            print(person)
//                            self.saveToPersistentStore()
                        }
                    }
                }
                
                self.saveToPersistentStore(context: backgroundMoc)
                completion(nil)
                
            } catch {
                NSLog("error decoding PersonRepresentations: \(error)")
                completion(error)
            }
        }.resume()
    }
    
    //delete
    func deletePersonFromServer(_ person: Person, completion: @escaping (Error?) -> Void = { _ in }) {
        let identifier = person.identifier ?? UUID().uuidString
        
        let url = baseURL.appendingPathComponent(identifier).appendingPathExtension("json")
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        let encoder = JSONEncoder()
        
        do {
            let taskJSON = try encoder.encode(person)
            
            request.httpBody = taskJSON
        } catch {
            NSLog("unable to encode person representation: \(error)")
            completion(error)
        }
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error putting person to server: \(error)")
                completion(error)
                return
            }
            completion(nil)
        }.resume()
    }
    
    func delete(person: Person) {
        let moc = CoreDataStack.shared.mainContext
        moc.delete(person)
        
        deletePersonFromServer(person)
    }
}
