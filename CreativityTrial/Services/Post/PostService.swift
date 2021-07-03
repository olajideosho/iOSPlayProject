//
//  PostService.swift
//  CreativityTrial
//
//  Created by Olajide Osho on 03/07/2021.
//

import Foundation

struct PostService {
    private var resultDelegate: HttpResultDelegate?
    let baseURL: String = "https://jsonplaceholder.typicode.com/posts"
    
    init(_ resultDelegate: HttpResultDelegate) {
        self.resultDelegate = resultDelegate
    }
    func getPosts() {
        HttpClient.getClient().get(baseURL, resultDelegate, [PostDTO].self)
    }
    
    func sendPost(_ post: PostRequest){
        HttpClient.getClient().post(baseURL, post, resultDelegate, PostDTO.self)
    }
}
