//
//  HomeViewController.swift
//  CreativityTrial
//
//  Created by Olajide Osho on 02/07/2021.
//

import UIKit
import iCarousel

class HomeViewController: BaseViewController, HomeViewModelDelegate {
    var viewModel: HomeViewModel?
    var carouselView: iCarousel?
    
    @IBOutlet weak var carouselParentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupCarouselView()
        
        viewModel = HomeViewModel(self)
        viewModel?.fetchPosts()
    }
    
    func setupCarouselView(){
        carouselView = iCarousel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 40, height: 200))
        carouselView?.type = .linear
        carouselView?.delegate = self
        carouselView?.dataSource = self
        carouselView?.decelerationRate = 0.5
        carouselParentView.addSubview(carouselView!)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewModel?.fetchPosts()
    }
    
    func receivedPosts(_ posts: [PostDTO]) {
        DispatchQueue.main.async {
            self.carouselView?.reloadData()
        }
    }
    
    func receivedError(_ error: APIError) {
        PopUpOverlay.showMessage(false, error.errorMessage!) {
            print("Action Clicked")
        }
    }
}

extension HomeViewController: iCarouselDataSource, iCarouselDelegate {
    func numberOfItems(in carousel: iCarousel) -> Int {
        return viewModel?.posts?.count ?? 0
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        guard let controller = storyboard?.instantiateViewController(identifier: "PostCarouselViewController") as? PostCarouselViewController else {
            return UIView()
        }
        let post = viewModel?.posts?[index] ?? PostDTO(userId: 0, id: 0, title: "null", body: "null")
        let view = controller.view
        view?.frame = CGRect(x: 0, y: 0, width: (view!.frame.width - 60), height: 186)
        controller.setupPostView(post)
        return view!
    }
    
    func carousel(_ carousel: iCarousel, didSelectItemAt index: Int) {
        let post = viewModel?.posts?[index] ?? PostDTO(userId: 0, id: 0, title: "null", body: "null")
        print(post.title!)
    }
    
    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        switch option {
        case .spacing:
            return 1.05
        default:
            return value
        }
    }
}
