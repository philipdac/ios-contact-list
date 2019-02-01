//
//  TableViewCell.swift
//  contactList
//
//  Created by Candy on 31/01/2019.
//  Copyright © 2019 EPITA. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var fullName: UILabel!    
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var thumnail: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func load(_ c: Contact, index: Int) {
        fullName.text = c.firstName.capitalized + " " + c.lastName.capitalized
        email.text = c.email
        
        if (c.thumnailUrl.count > 0) {
            do {
                let url = URL(string: c.thumnailUrl)
                let data = try Data(contentsOf: url!)
                thumnail.image = UIImage(data: data)
            }
            catch{
                print(error)
            }
        }
        
        self.backgroundColor = setCellColor(index: index)
    }
    
    func setCellColor(index: Int) -> UIColor
    {
        if (index % 2 == 0) {
            return UIColor(red: 0, green: CGFloat(168) / 255.0, blue: CGFloat(232) / 255.0, alpha: 0.3)
        }
        
        return UIColor(red: 0, green: CGFloat(168) / 255.0, blue: CGFloat(232) / 255.0, alpha: 0.1)
    }
}
