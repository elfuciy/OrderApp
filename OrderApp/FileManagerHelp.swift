//
//  FileMAnager.swift
//  OrderApp
//
//  Created by Elsever on 08.12.24.
//

import Foundation
class FileManagerHelp {
    enum FileName: String {
        case userFile = "userFile.json"
        case orderFile = "orderFile.json"
    }
    func getFile(fileName: FileName = .userFile ) -> URL {
        let files = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let path = files[0].appendingPathComponent(fileName.rawValue)
        return path
    }
    
    func readData(completion: (([UserInfo]) -> Void)) {
        if let data = try? Data(contentsOf: getFile(fileName: .userFile)) {
            do
            {
              let users = try JSONDecoder().decode([UserInfo].self, from: data)
                completion(users)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func writeData(user: [UserInfo]) {
        do {
            let data = try JSONEncoder().encode(user)
            let path = getFile(fileName: .userFile)
            try data.write(to: path)
        } catch {
            print(error.localizedDescription)
            
        }
    }
    
    
    func writeOrder(order: [Items]) {
        do {
            let data = try JSONEncoder().encode(order)
            let path = getFile(fileName: .orderFile)
            try data.write(to: path)
        } catch {
            print(error.localizedDescription)
            
        }
    }
    
    func getCategory(completion: (([CategoryFood]) -> Void)) {
        if let fileURL = Bundle.main.url(forResource: "CategoryFood", withExtension: "json") {
            print(fileURL)
            do {
                let data = try Data(contentsOf: fileURL)
                let categoryItems = try JSONDecoder().decode([CategoryFood].self, from: data)
                completion(categoryItems)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func readOrder(completion: (([Items]) -> Void)) {
        if let data = try? Data(contentsOf: getFile(fileName: .orderFile)) {
            do {
                let order = try JSONDecoder().decode([Items].self, from: data)
                completion(order)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func removeOrder() {
        let path = getFile(fileName: .orderFile)
        do {
            try FileManager.default.removeItem(at: path)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
}
