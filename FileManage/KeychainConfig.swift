//
//  KeychainConfig.swift
//  FileManage
//
//  Created by Кирилл Тила on 03.06.2021.
//

import Foundation
import KeychainAccess

struct KeychainConfig {
    static let keychan = Keychain(service: "KirillTila.FileManage")
    
}
