//
//  DownloadOperation.swift
//  PhoneBookFromAPI
//
//  Created by Gushchin Ilya on 28.03.2021.
//

import Foundation


class DownloadOperation: Operation {
    var resultContactList: [Contact] = []
    
    override func main() {
        if isCancelled {
            return
        }
        let contactsRepo = GistConstactsRepository(
            path: "https://gist.githubusercontent.com/artgoncharov/d257658423edd46a9ead5f721b837b8c/raw/c38ace33a7c871e4ad3b347fc4cd970bb45561a3/contacts_data.json")
        do {
            resultContactList = try contactsRepo.getContacts()
        } catch {
            print("error \(error)")
        }
       
    }
}
