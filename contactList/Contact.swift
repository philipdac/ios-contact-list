//
//  Contact.swift
//  contactList
//
//  Created by Candy on 31/01/2019.
//  Copyright © 2019 EPITA. All rights reserved.
//

import Foundation
import UIKit

class Contact {
    
    var title: String
    var firstName: String
    var lastName: String
    var street: String
    var city: String
    var email: String
    var phone: String
    var cellPhone: String
    var thumnailUrl: String
    var pictureUrl: String
    
    init(json: NSDictionary) {
        
        let name = json["name"] as? NSDictionary ?? [
            "title" : "",
            "first" : "",
            "last" : ""
        ]
        self.title = name["title"] as? String ?? ""
        self.firstName = name["first"] as? String ?? ""
        self.lastName = name["last"] as? String ?? ""
        
        let location = json["location"] as? NSDictionary ?? [
            "street" : "",
            "city" : ""
        ]
        self.street = location["street"] as? String ?? ""
        self.city = location["city"] as? String ?? ""
        
        self.email = json["email"] as? String ?? ""
        self.phone = json["phone"] as? String ?? ""
        self.cellPhone = json["cell"] as? String ?? ""
        
        let pic = json["picture"] as? NSDictionary ?? [
            "large" : "",
            "thumnail" : ""
        ]
        self.thumnailUrl = pic["thumbnail"] as? String ?? ""
        self.pictureUrl = pic["large"] as? String ?? ""
        
        self.title = title.capitalized
        self.firstName = firstName.capitalized
        self.lastName = lastName.capitalized
        self.city = city.capitalized
    }
}
