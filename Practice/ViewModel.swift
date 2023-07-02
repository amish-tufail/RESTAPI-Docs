//
//  ViewModel.swift
//  Practice
//
//  Created by Amish on 02/07/2023.
//

import Foundation
import SwiftData

@Observable class ViewModel {
    let URLL = "https://jsonplaceholder.typicode.com/posts"
    var modelData: [Model] = []
    
    init() {
        getData()
    }
    
    // FETCH REQUEST
    func getData() {
        downloadData(url: URLL) { downloadedData in
            if let downloadedData = downloadedData {
                let decoder = JSONDecoder()
                do {
                    let decodedData = try decoder.decode([Model].self, from: downloadedData)
                    self.modelData = decodedData
                } catch {
                    print(ErrorOccured.noData)
                }
            }
        }
    }
    
    func downloadData(url: String, handler: @escaping (_ data: Data?) -> ()) {
        guard let url = URL(string: url) else {
            return print(ErrorOccured.InvalidURL.localizedDescription)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil, let response = response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else {
                handler(nil)
                return print(ErrorOccured.NetworkError)
            }
            handler(data)
        }.resume()
    }
    
    // POST REQUEST
    func createPost() {
        // Creating a Post
        let post = Model(userId: 200, id: 200, title: "Amish Tufail", body: "I am an iOS Developer!")
        guard let url = URL(string: URLL) else {
            return print(ErrorOccured.InvalidURL)
        }
        
        // Specifying Call
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-type")
        
        // Encoding the data into JSON
        do {
            let encoder = JSONEncoder()
            // Sending the data to the API
            request.httpBody = try encoder.encode(post)
        } catch {
            print(ErrorOccured.EncodingError.localizedDescription)
        }
        
        // Now downloading that data we sent to the API
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil, let response = response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else {
                return print(ErrorOccured.NetworkError)
            }
            // Here we decoding that data we sent to the API
            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode(Model.self, from: data)
                // Appending it to the existing one
                self.modelData.append(decodedData)
            } catch {
                print(ErrorOccured.noData)
            }
        }.resume()
    }
    
    // DELETE REQUEST
    func deletePost() {
        
        // Here you specify the id in the url of the post you want to delete as here we put id 1
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts/1") else {
            return print(ErrorOccured.InvalidURL)
        }
        
        // Specify Method
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        // It deletes the data and status code would be 200
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil, let response = response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else {
                return print(ErrorOccured.NetworkError)
            }
            print(response.statusCode)
        }.resume()
    }
    
    // PATCH REQUEST
    func patchPost() {
        let updatePost = Model(userId: 1000, id: 1000, title: "HAHAHAHA", body: "EHEHEHEHEHEHEHEHEHEHEHEHEHEHEHEHEH!")
        // Specify the post you want to update by giving its id in the url
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts/1") else {
            return print(ErrorOccured.InvalidURL)
        }
        
        // Specify Method
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.addValue("application/JSON", forHTTPHeaderField: "Content-type")
        
        // Encoding the data into JSON
        do {
            let encoder = JSONEncoder()
            // Sending the data to the API
            request.httpBody = try encoder.encode(updatePost)
        } catch {
            print(ErrorOccured.EncodingError.localizedDescription)
        }
        
        // Now downloading that data we sent to the API
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil, let response = response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else {
                return print(ErrorOccured.NetworkError)
            }
            
            print(String(data: data, encoding: .utf8)!)
            // Here we decoding that data we sent to the API
            // NO NEED TO DO THIS, this is just a fake api so we append it but in real api it would be updated auto
            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode(Model.self, from: data)
                // Appending it to the existing one
                self.modelData.append(decodedData)
            } catch {
                print(ErrorOccured.noData)
            }
        }.resume()
        
    }
    
}

enum ErrorOccured: Error {
    case InvalidURL
    case noData
    case NetworkError
    case EncodingError
}
