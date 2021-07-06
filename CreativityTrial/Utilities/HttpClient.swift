//
//  HttpClient.swift
//  CreativityTrial
//
//  Created by Olajide Osho on 03/07/2021.
//

import Foundation

struct HttpClient {
    private static var client: HttpClient!
    
    static func getClient() -> HttpClient {
        if client == nil {
            client = HttpClient()
        }
        return client
    }
    
    func get<T: Codable>(_ url: String, _ responseType: T.Type, _ completion: @escaping (T?, APIError?) -> Void) {
        guard let endpoint = URL(string: url) else {
            completion(nil, APIError(errorCode: 0, errorMessage: "URL provided is invalid"))
            return
        }
        
        var request = URLRequest(url: endpoint)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) {
            data, response, error in
            if error != nil {
                let httpResponse = response as? HTTPURLResponse
                completion(nil, APIError(errorCode: httpResponse?.statusCode ?? 0, errorMessage: error?.localizedDescription ?? "An Error Occured"))
                return
            }
            
            do{
                let result = try JSONDecoder().decode(responseType, from: data!)
                completion(result, nil)
                return
            } catch {
                completion(nil, APIError(errorCode: 0, errorMessage: error.localizedDescription))
                return
            }
        }.resume()
    }
    
    func post<T: Codable, L: Codable>(_ url: String, _ payload: T, _ responseType: L.Type, _ completion: @escaping (L?, APIError?) -> Void) {
        guard let endpoint = URL(string: url) else {
            completion(nil, APIError(errorCode: 0, errorMessage: "URL provided is invalid"))
            return
        }
        
        var request = URLRequest(url: endpoint)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        do {
            request.httpBody = try JSONEncoder().encode(payload)
        } catch {
            completion(nil, APIError(errorCode: 0, errorMessage: error.localizedDescription))
            return
        }
        
        URLSession.shared.dataTask(with: request) {
            data, response, error in
            if error != nil {
                let httpResponse = response as? HTTPURLResponse
                completion(nil, APIError(errorCode: httpResponse?.statusCode ?? 0, errorMessage: error?.localizedDescription ?? "An Error Occured"))
                return
            }
            
            do{
                let result = try JSONDecoder().decode(responseType, from: data!)
                completion(result, nil)
                return
            } catch {
                completion(nil, APIError(errorCode: 0, errorMessage: error.localizedDescription))
                return
            }
        }.resume()
    }
}
