//
//  InfoViewController.swift
//  PhoneBookFromAPI
//
//  Created by Gushchin Ilya on 24.03.2021.
//

import UIKit

class InfoViewController: UIViewController {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var surnameLabel: UILabel!
    @IBOutlet var phoneLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!
    var contact: Contact? = nil
    
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
    }
    
    func setViews(){
        guard let contact = contact else {
            return
        }
        nameLabel.text = contact.firstname
        surnameLabel.text = contact.lastname
        phoneLabel.text = contact.phone
        emailLabel.text = contact.email
    }
}
