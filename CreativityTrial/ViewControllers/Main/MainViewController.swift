//
//  HomeViewController.swift
//  CreativityTrial
//
//  Created by Olajide Osho on 02/07/2021.
//

import UIKit

class MainViewController: UIViewController {
    
    enum Screen: String {
        case Home
        case About
    }

    @IBOutlet weak var sideMenuView: UIView! //Handled
    @IBOutlet weak var sideMenuHomeButton: UIButton! //Handled
    @IBOutlet weak var sideMenuAboutButton: UIButton! //Handled
    @IBOutlet weak var sideMenuLogoutButton: UIButton! //Handled
    @IBOutlet weak var sideMenuExposeButton: UIImageView!
    @IBOutlet weak var tabBarHomeButton: UIImageView! //Handled
    @IBOutlet weak var tabBarInfoButton: UIImageView! //Handled
    @IBOutlet weak var sideMenuConstraint: NSLayoutConstraint! //Handled
    @IBOutlet weak var currentScreenLabel: UILabel! //Handled
    @IBOutlet weak var contentView: UIView! //Handled
    @IBOutlet weak var sideMenuUserView: UIView! //Handled
    
    var homeViewController: HomeViewController?
    var aboutViewController: AboutViewController?
    
    var sideMenuHidden: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PopUpOverlay.firstViewController = self
        configureViewAndFunctions()
    }
    
    private func configureViewAndFunctions(){
        
        // Hamburger Menu Button Configuration
        let sideMenuExposeTap = UITapGestureRecognizer(target: self, action: #selector(exposeSideMenu))
        sideMenuExposeButton.addGestureRecognizer(sideMenuExposeTap)
        
        // Side Menu View Configuration
        sideMenuUserView.layer.cornerRadius = 20
        
        // Tab Bar Configuration
        let tabBarHomeTap = UITapGestureRecognizer(target: self, action: #selector(homeTabTapped))
        tabBarHomeButton.addGestureRecognizer(tabBarHomeTap)
        let tabBarAboutTap = UITapGestureRecognizer(target: self, action: #selector(aboutTabTapped))
        tabBarInfoButton.addGestureRecognizer(tabBarAboutTap)
        
        configureView(.Home)
    }
    
    @objc func homeTabTapped(){
        configureView(.Home)
    }
    
    @objc func aboutTabTapped(){
        configureView(.About)
    }
    
    private func configureView(_ screen: Screen){
        UIView.performWithoutAnimation {
            let existingViews = contentView.subviews
            if existingViews.count > 0 {
                for v in existingViews {
                    v.removeFromSuperview()
                }
            }
            
            currentScreenLabel.text = screen.rawValue
            
            if screen == .Home {
                configureHomeView()
            } else {
                configureAboutView()
            }
            view.layoutIfNeeded()
        }
    }
    
    private func configureHomeView(){
        sideMenuHomeButton.setTitleColor(.black, for: .normal)
        sideMenuAboutButton.setTitleColor(.white, for: .normal)
        tabBarHomeButton.tintColor = .black
        tabBarInfoButton.tintColor = .darkGray
        
        if homeViewController == nil {
            homeViewController = storyboard?.instantiateViewController(identifier: "HomeViewController") as? HomeViewController
        }
        
        if let controller = homeViewController, let homeView = controller.view {
            homeView.frame = contentView.bounds
            homeView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            self.contentView.addSubview(homeView)
        }
    }
    
    private func configureAboutView(){
        sideMenuHomeButton.setTitleColor(.white, for: .normal)
        sideMenuAboutButton.setTitleColor(.black, for: .normal)
        tabBarHomeButton.tintColor = .darkGray
        tabBarInfoButton.tintColor = .black
        
        if aboutViewController == nil {
            aboutViewController = storyboard?.instantiateViewController(identifier: "AboutViewController") as? AboutViewController
        }
        
        if let controller = aboutViewController, let aboutView = controller.view {
            aboutView.frame = contentView.bounds
            aboutView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            self.contentView.addSubview(aboutView)
        }
    }
    
    @objc func exposeSideMenu(){
        if(sideMenuHidden){
            sideMenuExposeButton.image = UIImage(systemName: "xmark.circle.fill")
            UIView.animate(withDuration: 0.4) {
                self.sideMenuConstraint.constant = 0
                self.view.layoutIfNeeded()
            }
            sideMenuHidden = false
        } else{
            sideMenuExposeButton.image = UIImage(systemName: "line.horizontal.3")
            UIView.animate(withDuration: 0.4) {
                self.sideMenuConstraint.constant = -240
                self.view.layoutIfNeeded()
            }
            sideMenuHidden = true
        }
    }
    
    @IBAction func sideMenuHomeClicked(_ sender: UIButton) {
        configureView(.Home)
        exposeSideMenu()
    }
    
    @IBAction func sideMenuAboutClicked(_ sender: UIButton) {
        configureView(.About)
        exposeSideMenu()
    }
}
