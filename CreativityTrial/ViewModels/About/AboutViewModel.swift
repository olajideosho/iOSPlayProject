//
//  AboutViewModel.swift
//  CreativityTrial
//
//  Created by Olajide Osho on 03/07/2021.
//

import Foundation
import UIKit

protocol AboutViewModelDelegate {
    func notifyDataChanged()
    func error(_ error: APIError)
}

class AboutViewModel: HttpResultDelegate {
    
    var loadingDelegate: LoadingOverlayDelegate?
    var viewModelDelegate: AboutViewModelDelegate?
    var postService: PostService?
    var posts: [Post]?
    var postRequest: PostRequest = PostRequest(id: 0, title: "", body: "")
    
    init(_ viewModelDelegate: UIViewController) {
        self.loadingDelegate = viewModelDelegate as? LoadingOverlayDelegate
        self.viewModelDelegate = viewModelDelegate as? AboutViewModelDelegate
    }
    
    func getPosts(_ searchText: String) {
        posts = LocalDatabase.getAllPosts(searchText)
        viewModelDelegate?.notifyDataChanged()
    }
    
    func sendPost() {
        if postService == nil {
            postService = PostService(self)
        }
        guard postRequest.id != 0,
              !postRequest.title.trimmingCharacters(in: .whitespaces).isEmpty,
              !postRequest.body.trimmingCharacters(in: .whitespaces).isEmpty else {
            viewModelDelegate?.error(APIError(errorCode: 0, errorMessage: "Invalid data"))
            return
        }
        loadingDelegate?.isLoading(true)
        postService?.sendPost(self.postRequest)
    }
    
    func successWithData(_ data: Any) {
        DispatchQueue.main.async {
            self.loadingDelegate?.isLoading(false)
        }
        if let post = data as? PostDTO {
            LocalDatabase.createPost(post.id!, post.title!, post.body!)
            getPosts("")
        }
        clearPostRequest()
    }
    
    func errorWithStatus(_ status: APIError) {
        DispatchQueue.main.async {
            self.loadingDelegate?.isLoading(false)
        }
        viewModelDelegate?.error(status)
        clearPostRequest()
    }
    
    func clearPostRequest() {
        postRequest.body = ""
        postRequest.title = ""
        postRequest.id = 0
    }
}
