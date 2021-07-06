//
//  PostService.swift
//  CreativityTrial
//
//  Created by Olajide Osho on 03/07/2021.
//

import Foundation

struct PostService {
    let baseURL: String = "https://jsonplaceholder.typicode.com/posts"
    
    func getPosts(_ completion: @escaping (Any?, APIError?) -> Void) {
        HttpClient.getClient().get(baseURL, [PostDTO].self, completion)
    }
    
    func sendPost(_ post: PostRequest, _ completion: @escaping (Any?, APIError?) -> Void){
        HttpClient.getClient().post(baseURL, post, PostDTO.self, completion)
    }
}
