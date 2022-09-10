//
//  UserModel.swift
//  ContactsApp_ThihaYeYintAung
//
//  Created by Thiha Ye Yint Aung on 9/9/22.
//

import SwiftUI

/// A struct for decoding JSON with the following structure:
//{
//  "data": [
//    {
//      "id": 1,
//      "name": "cerulean",
//      "year": 2000,
//      "color": "#98B2D1",
//      "pantone_value": "15-4020"
//    }
//  ]
//}

struct User: Decodable {
    private enum RootCodingKeys: String, CodingKey {
        case data
    }
    
    private enum UserCodingKeys: String, CodingKey {
        case id
        case email
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar
    }
    
    private(set) var userArray = [UserDetail]()
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RootCodingKeys.self)
        var dataUnkeyedContainer = try container.nestedUnkeyedContainer(forKey: .data)
        
        while !dataUnkeyedContainer.isAtEnd {
            let userContainer = try dataUnkeyedContainer.nestedContainer(keyedBy: UserCodingKeys.self)
            
            let id = try userContainer.decode(Int.self, forKey: .id)
            let firstName = try? userContainer.decode(String.self, forKey: .firstName)
            let lastName = try? userContainer.decode(String.self, forKey: .lastName)
            let email = try? userContainer.decode(String.self, forKey: .email)
            let avatar = try? userContainer.decode(String.self, forKey: .avatar)
            
            userArray.append(UserDetail(id: id, email: email, firstName: firstName, lastName: lastName, avatar: avatar))
        }
    }
}

struct UserDetail: Codable {
    var id: Int
    var email: String?
    var firstName: String?
    var lastName: String?
    var avatar: String?
    
    private enum UserCodingKeys: String, CodingKey {
        case id
        case email
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar
    }
    
    var dictionaryValue: [String: Any] {
        [
            "id": id,
            "email": email ?? "",
            "first_name": firstName ?? "",
            "last_name": lastName ?? "",
            "avatar": avatar ?? "",
            "phone": "",
            "created_date": Date()
        ]
    }
}
