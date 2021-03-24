//
//  ViewController.swift
//  PhoneBookFromAPI
//
//  Created by Gushchin Ilya on 24.03.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var buttonUseGCD: UIButton!
    
    @IBOutlet var buttonUseOperationQueue: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "gotoListWithGCD") {
            let destination = segue.destination as! PhoneListViewController
            destination.isGCD = true
        } else
        if (segue.identifier == "gotoListAndQueue") {
            let destination = segue.destination as! PhoneListViewController
            destination.isGCD = false
        }
    }
}

