//
//  AddRecordVC.swift
//  RealMDemo
//
//  Created by Harendra Sharma on 10/04/20.
//  Copyright © 2020 Harendra Sharma. All rights reserved.
//

import Toast_Swift
import UIKit

class AddRecordVC: UIViewController {
    @IBOutlet var TFName: UITextField!
    @IBOutlet var TFStandard: UITextField!
    @IBOutlet var TFAge: UITextField!
    @IBOutlet var TFAddress: UITextField!

    private var style = ToastStyle()

    private lazy var dbViewModel: RealMViewModel = {
        let vm = RealMViewModel()
        vm.delegate = self
        return vm
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func SaveRecord(_ sender: UIButton) {
        // creating student obj
        // realM support various data type i.e string, int, array but I using string only
        let student = Student()
        student.name = TFName.text ?? ""
        student.standerd = TFStandard.text ?? ""
        student.age = TFAge.text ?? ""
        student.address = TFAddress.text ?? ""
        self.view.endEditing(true)
        dbViewModel.saveRecord(student: student) // save record to database
    }
}

// MARK: RealMViewModelDelegate Methods
extension AddRecordVC: RealMViewModelDelegate {
    func RecordSaved() {
        TFName.text = ""
        TFStandard.text = ""
        TFAge.text = ""
        TFAddress.text = ""
        self.view.makeToast("Record saved in RealM DB", duration: 3.0, position: .bottom, style: style)
    }

    func RecordSavingFailed(error: NSError) {
        self.view.makeToast(error.localizedDescription, duration: 3.0, position: .bottom, style: style)
    }
}
