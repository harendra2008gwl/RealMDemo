//
//  ShowRecordsVC.swift
//  RealMDemo
//
//  Created by Harendra Sharma on 10/04/20.
//  Copyright © 2020 Harendra Sharma. All rights reserved.
//

import RealmSwift
import Toast_Swift
import UIKit

class ShowRecordsVC: UIViewController {
    @IBOutlet var tblRecords: UITableView!
    private var students: [Student]?
    private let cellIdentifier = "StudentCell"
    private var lastSelectedIndex = 0
    private var style = ToastStyle()

    private lazy var dbViewModel: RealMViewModel = {
        let vm = RealMViewModel()
        vm.delegate = self
        return vm
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetup()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        tblRecords.isHidden = true
        dbViewModel.fetchStudends()
    }

    private func initialSetup() {
        self.tblRecords.delegate = self
        self.tblRecords.dataSource = self
        self.registerNibs()
    }

    private func registerNibs() {
        tblRecords.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }

    @IBAction func dismiss(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension ShowRecordsVC: UITableViewDelegate, UITableViewDataSource {
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.students?.count ?? 0
    }

    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: StudentCell = self.tblRecords.dequeueReusableCell(withIdentifier: cellIdentifier) as! StudentCell
        cell.TFName.text = "Name: \(self.students?[indexPath.row].name ?? "")"
        cell.TFAge.text = "Age: \(self.students?[indexPath.row].age ?? "")"
        cell.TFStandard.text = "Student: \(self.students?[indexPath.row].standerd ?? "")"
        cell.TFAddress.text = "Address: \(self.students?[indexPath.row].address ?? "")"
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let student = self.students?[indexPath.row] {
                self.lastSelectedIndex = indexPath.row
                self.dbViewModel.deleteRecord(student: student)
            } else {
                self.view.makeToast("Record Not found", duration: 3.0, position: .bottom, style: style)
            }
        }
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
    }
}

// MARK: RealMViewModelDelegate Methods

extension ShowRecordsVC: RealMViewModelDelegate {
    func RecordFetched(students: [Student]) {
        if students.count > 0 {
            self.students = students
            DispatchQueue.main.async {
                self.tblRecords.reloadData()
                self.tblRecords.isHidden = false
            }
        } else {
            self.tblRecords.isHidden = true
            self.view.makeToast("No record found", duration: 3.0, position: .bottom, style: style)
        }
    }

    func RecordDeleted() {
        self.view.makeToast("Record deleted from DB", duration: 3.0, position: .bottom, style: style)
        self.students?.remove(at: lastSelectedIndex)
        DispatchQueue.main.async {
            self.tblRecords.reloadData()
        }
    }
}
