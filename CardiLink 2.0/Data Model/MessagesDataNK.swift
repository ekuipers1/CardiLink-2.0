//
//  MessagesDataNK.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 22.11.21.
//

import Foundation

struct MessageData: Codable, Identifiable{
    var id: String?
    var timeStamp: String?
    var messageType: String?
    var transmissionAttempts: String?
}
struct DataNK: Codable, Identifiable{

    var id: String?
    var timeStamp: String?
    var messageType: String?
    var transmissionAttempts: String?

}

