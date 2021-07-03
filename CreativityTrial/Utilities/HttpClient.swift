//
//  HttpClient.swift
//  CreativityTrial
//
//  Created by Olajide Osho on 03/07/2021.
//

import Foundation

protocol HttpResultDelegate {
    func successWithData(_ data: Any)
    func errorWithStatus(_ status: APIError)
}

struct HttpClient {
    private static var client: HttpClient!
    private var resultDelegate: HttpResultDelegate!
    
    static func getClient() -> HttpClient {
        if client == nil {
            client = HttpClient()
        }
        return client
    }
    
    func get<T: Codable>(_ url: String, _ resultDelegate: HttpResultDelegate?, _ responseType: T.Type) {
        guard let endpoint = URL(string: url) else {
            resultDelegate?.errorWithStatus(APIError(errorCode: 0, errorMessage: "URL provided is invalid"))
            return
        }
        
        var request = URLRequest(url: endpoint)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) {
            data, response, error in
            if error != nil {
                let httpResponse = response as? HTTPURLResponse
                resultDelegate?.errorWithStatus(APIError(errorCode: httpResponse?.statusCode ?? 0, errorMessage: error?.localizedDescription ?? "An Error Occured"))
                return
            }
            
            do{
                let result = try JSONDecoder().decode(responseType, from: data!)
                resultDelegate?.successWithData(result)
                return
            } catch {
                resultDelegate?.errorWithStatus(APIError(errorCode: 0, errorMessage: error.localizedDescription))
                return
            }
        }.resume()
    }
    
    func post<T: Codable, L: Codable>(_ url: String, _ payload: T, _ resultDelegate: HttpResultDelegate?, _ responseType: L.Type) {
        guard let endpoint = URL(string: url) else {
            resultDelegate?.errorWithStatus(APIError(errorCode: 0, errorMessage: "URL provided is invalid"))
            return
        }
        
        var request = URLRequest(url: endpoint)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        do {
            request.httpBody = try JSONEncoder().encode(payload)
        } catch {
            resultDelegate?.errorWithStatus(APIError(errorCode: 0, errorMessage: error.localizedDescription))
            print(error.localizedDescription)
            return
        }
        
        URLSession.shared.dataTask(with: request) {
            data, response, error in
            if error != nil {
                let httpResponse = response as? HTTPURLResponse
                resultDelegate?.errorWithStatus(APIError(errorCode: httpResponse?.statusCode ?? 0, errorMessage: error?.localizedDescription ?? "An Error Occured"))
                return
            }
            
            do{
                let result = try JSONDecoder().decode(responseType, from: data!)
                resultDelegate?.successWithData(result)
                return
            } catch {
                resultDelegate?.errorWithStatus(APIError(errorCode: 0, errorMessage: error.localizedDescription))
                return
            }
        }.resume()
    }
}
