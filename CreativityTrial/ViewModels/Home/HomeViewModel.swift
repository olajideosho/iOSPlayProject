//
//  HomeViewModel.swift
//  CreativityTrial
//
//  Created by Olajide Osho on 02/07/2021.
//

import Foundation
import UIKit

protocol HomeViewModelDelegate {
    func receivedPosts(_ posts: [PostDTO])
    func receivedError(_ error: APIError)
}

class HomeViewModel {
    
    var loadingDelegate: LoadingOverlayDelegate?
    var viewModelDelegate: HomeViewModelDelegate?
    var postService: PostService?
    var posts: [PostDTO]?
    
    init(_ viewModelDelegate: UIViewController) {
        self.loadingDelegate = viewModelDelegate as? LoadingOverlayDelegate
        self.viewModelDelegate = viewModelDelegate as? HomeViewModelDelegate
    }
    
    func fetchPosts(){
        if postService == nil {
            postService = PostService()
        }
        loadingDelegate?.isLoading(true)
        postService?.getPosts(fetchPostCompletion(_:_:))
    }
    
    func fetchPostCompletion(_ data: Any?, _ error: APIError?) -> Void {
        if let status = error {
            DispatchQueue.main.async {
                self.loadingDelegate?.isLoading(false)
            }
            viewModelDelegate?.receivedError(status)
            return
        }
        DispatchQueue.main.async {
            self.loadingDelegate?.isLoading(false)
        }
        if var posts = data as? [PostDTO] {
            if posts.count > 5 {
                posts = Array(posts[0..<5])
            }
            self.posts = posts
            viewModelDelegate?.receivedPosts(posts)
        }
    }
}
