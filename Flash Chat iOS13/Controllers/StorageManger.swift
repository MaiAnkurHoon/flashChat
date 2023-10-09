//
//  StorageManger.swift
//  Flash Chat iOS13
//
//  Created by Ankur Mazumder  on 18/09/23.
//  Copyright © 2023 Angela Yu. All rights reserved.
//

import Foundation
import FirebaseCoreExtension
import GTMSessionFetcher

import FirebaseCore
import FirebaseStorage
class StorageManger{
    static let shared = StorageManger()
    private let storage =  Storage.storage().reference()
///uploads pics to firebase
    
    public func uploadDP(withData:Data , filename: String, completion : @escaping(String) -> Void){
        
    }
    
}
