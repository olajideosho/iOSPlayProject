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

class HomeViewModel: HttpResultDelegate {
    
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
            postService = PostService(self)
        }
        loadingDelegate?.isLoading(true)
        postService?.getPosts()
    }
    
    func successWithData(_ data: Any) {
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
    
    func errorWithStatus(_ status: APIError) {
        DispatchQueue.main.async {
            self.loadingDelegate?.isLoading(false)
        }
        viewModelDelegate?.receivedError(status)
    }
}
