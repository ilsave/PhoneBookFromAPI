//
//  PhoneListViewController.swift
//  PhoneBookFromAPI
//
//  Created by Gushchin Ilya on 24.03.2021.
//

import UIKit
import Foundation
import Dispatch

struct Contact: Codable {
    let firstname: String
    let lastname: String
    let email: String
    let phone: String

}

protocol ContactsRepository {
    func getContacts() throws -> [Contact]
}

class GistConstactsRepository: ContactsRepository {
    private let path: String
    init(path: String) {
        self.path = path
    }
    func getContacts() throws -> [Contact] {
        let sem = DispatchSemaphore(value: 0)
        let url = URL(string: path)
        let request = URLRequest(url: url!)
        var result: [Contact] = []
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            defer {
                sem.signal()
            }
           
            guard let data = data, error == nil else {
                return
            }
            
            do {
                result = try JSONDecoder().decode([Contact].self, from: data)
            } catch {
                print("Unexpected error: \(error).")
            }
            
        }
        task.resume()
        
        
        // TODO: add timeout
        let time: DispatchTime = .now() + .seconds(5)
        sem.wait(timeout: time)
        return result
    }
}

class PhoneListViewController: UIViewController {
    
    var isGCD: Bool

    @IBOutlet var tableView: UITableView!
    var totalList: [Contact] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
       
        
        print("PhoneList hello!")
        let contactsRepo = GistConstactsRepository(path: "https://gist.githubusercontent.com/artgoncharov/d257658423edd46a9ead5f721b837b8c/raw/c38ace33a7c871e4ad3b347fc4cd970bb45561a3/contacts_data.json")
        
        let queue = DispatchQueue.global(qos: .utility)
            queue.async{
               // let res: [Contact] = try! contactsRepo.getContacts()
                self.totalList = try! contactsRepo.getContacts()
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
        
    }
}

extension PhoneListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("you tapped me!")
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "InfoViewController") as! InfoViewController
        vc.contact = totalList[indexPath.row]
        self.present(vc, animated: true, completion: nil)
        
    }
}


extension PhoneListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return totalList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = totalList[indexPath.row].firstname
        return cell
    }
}
