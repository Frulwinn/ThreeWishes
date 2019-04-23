//
//  WishDetailViewController.swift
//  Gifting
//
//  Created by Lambda_School_Loaner_34 on 3/19/19.
//  Copyright © 2019 Frulwinn. All rights reserved.
//

import UIKit

class WishDetailViewController: UIViewController {
    
    //MARK: - Properties
    private var datePicker: UIDatePicker?
    //var selectedDate: Date?
    var personController: PersonController?
    var person: Person? {
        didSet {
            updateViews()
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: - Outlets
    @IBOutlet weak var celebratingLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var birthdayTextField: UITextField!
    @IBOutlet weak var giftLabel: UILabel!
    @IBOutlet weak var firstTextField: UITextField!
    @IBOutlet weak var secondTextField: UITextField!
    @IBOutlet weak var thirdTextField: UITextField!
    @IBOutlet weak var firstBuyButton: ChangeBuyButton!
    @IBOutlet weak var secondBuyButton: ChangeBuyButton!
    @IBOutlet weak var thirdBuyButton: ChangeBuyButton!
    
    
    @IBAction func save(_ sender: Any) {
        guard let name = nameTextField.text, !name.isEmpty,
            let firstChoice = firstTextField.text,
            let secondChoice = secondTextField.text,
            let thirdChoice = thirdTextField.text,
            let birthDay = birthdayTextField.text else { return }
        
        let date = self.dateFormatter.date(from: birthDay)!
        
        if let person = person {
            personController?.update(person, withName: name, birthday: date, firstChoice: firstChoice, secondChoice: secondChoice, thirdChoice: thirdChoice)
        } else {
            personController?.createPerson(with: name, birthday: date, firstChoice: firstChoice, secondChoice: secondChoice, thirdChoice: thirdChoice)
        }
        navigationController?.popViewController(animated: true)
    }
    
    func setThemes() {
        
        //text field
        nameTextField.font = Appearance.gillSansFont(with: .body, pointSize: 15)
        birthdayTextField.font = Appearance.gillSansFont(with: .body, pointSize: 15)
        firstTextField.font = Appearance.gillSansFont(with: .body, pointSize: 15)
        secondTextField.font = Appearance.gillSansFont(with: .body, pointSize: 15)
        thirdTextField.font = Appearance.gillSansFont(with: .body, pointSize: 15)

        //labels
        celebratingLabel.font = Appearance.gillSansFont(with: .body, pointSize: 20)
        celebratingLabel.textColor = .deepRed
        giftLabel.font = Appearance.gillSansFont(with: .body, pointSize: 20)
        giftLabel.textColor = .deepRed
        
        //buttons
        Appearance.style(button: firstBuyButton)
        Appearance.style(button: secondBuyButton)
        Appearance.style(button: thirdBuyButton)

        //background
        view.backgroundColor = .deepRed
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNeedsStatusBarAppearanceUpdate()
        setThemes()
        updateViews()
        
        //date picker
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.addTarget(self, action: #selector(WishDetailViewController.dateChanged(datePicker:)), for: .valueChanged)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(WishDetailViewController.viewTapped(gestureRecognizer:)))
        
        view.addGestureRecognizer(tapGesture)
        
        birthdayTextField.inputView = datePicker
    }
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @objc func dateChanged(datePicker: UIDatePicker) {
       let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d"
        
        birthdayTextField.text = dateFormatter.string(from: datePicker.date)
        
        view.endEditing(true)
    }
    
    func updateViews() {
        guard isViewLoaded else { return }
        guard let person = person,
        let birthday = person.birthday
        else {
            title = "ADD PERSON"
            return
        }
        
        title = person.name
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d"
        
        nameTextField.text = person.name
        birthdayTextField.text = self.dateFormatter.string(from: birthday)
        firstTextField.text = person.firstChoice
        secondTextField.text = person.secondChoice
        thirdTextField.text = person.thirdChoice
    }
}
