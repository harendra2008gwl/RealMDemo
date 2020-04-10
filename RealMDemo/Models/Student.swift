//
//  Student.swift
//  RealMDemo
//
//  Created by Harendra Sharma on 10/04/20.
//  Copyright © 2020 Harendra Sharma. All rights reserved.
//

import UIKit
import RealmSwift

class Student: Object {
    @objc dynamic var name = ""
    @objc dynamic var standerd = ""
    @objc dynamic var age = ""
    @objc dynamic var address = ""
}

