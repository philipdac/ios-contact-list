//
//  DetailViewController.swift
//  contactList
//
//  Created by Candy on 31/01/2019.
//  Copyright © 2019 EPITA. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var contactPhoto: UIImageView!
    @IBOutlet weak var contactTitle: UILabel!
    @IBOutlet weak var contactName: UILabel!
    @IBOutlet weak var contactEmail: UILabel!
    @IBOutlet weak var contactCell: UILabel!
    @IBOutlet weak var contactPhone: UILabel!
    @IBOutlet weak var contactAddr: UILabel!
    
    var contact: Contact?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let contact = contact {
            contactTitle.text = contact.title
            contactName.text = contact.firstName + " " + contact.lastName
            contactEmail.text = contact.email
            contactCell.text = contact.cellPhone
            contactPhone.text = contact.phone
            contactAddr.text = contact.street + ". " + contact.city
            
            do {
                let url = URL(string: contact.pictureUrl)
                let data = try Data(contentsOf: url!)
                contactPhoto.image = UIImage(data: data)
            }
            catch{
                print(error)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
