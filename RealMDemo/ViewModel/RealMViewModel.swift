//
//  RealMViewModel.swift
//  RealMDemo
//
//  Created by Harendra Sharma on 10/04/20.
//  Copyright © 2020 Harendra Sharma. All rights reserved.
//

import RealmSwift
import UIKit

// MARK: DB protocol Methods

protocol RealMViewModelDelegate {
    func RecordSaved()
    func RecordSavingFailed(error: NSError)
    func RecordFetched(students: [Student])
    func RecordDeleted()
}

// Make RealMViewModelDelegate methods optionals
extension RealMViewModelDelegate {
    func RecordSaved() {}
    func RecordSavingFailed(error: NSError) {}
    func RecordFetched(students: [Student]) {}
    func RecordDeleted(){}
}

class RealMViewModel: NSObject {
    let realm = try! Realm()
    var delegate: RealMViewModelDelegate?

    // MARK: DB Helper Methods

    func saveRecord(student: Student) {
        // Persist your data easily
        try! realm.write {
            realm.add(student)
            delegate?.RecordSaved() // Notify for succesful insertion
        }
        // Note: here we can handle error in catch block and notify using
        // RecordSavingFailed(error: NSError)
    }
    
    func fetchStudends(){
        let students = realm.objects(Student.self)
        if students.count > 0 {
            var dumppyStudents = [Student]()
            for student in students {
                dumppyStudents.append(student)
            }
            delegate?.RecordFetched(students: dumppyStudents) // Notify with records
        } else {
            delegate?.RecordFetched(students: [])
        }
    }
    
    func deleteRecord(student: Student) {
           // Persist your data easily
           try! realm.write {
               realm.delete(student)
               delegate?.RecordDeleted() // Notify for succesful deletion
           }
       }
}

