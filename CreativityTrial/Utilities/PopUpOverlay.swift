//
//  PopUpOverlay.swift
//  CreativityTrial
//
//  Created by Olajide Osho on 02/07/2021.
//

import Foundation
import UIKit
import Lottie

protocol LoadingOverlayDelegate {
    func isLoading(_ loading: Bool)
}

struct PopUpOverlay {
    // Used in View Controller
    private static var loadingController: LoadingViewController?
    private static var popUpController: PopUpViewController?
    static var firstViewController: UIViewController?
    
    static func showMessage(_ success: Bool, _ message: String, _ buttonAction: @escaping ()-> Void){
        DispatchQueue.main.async {
            if let popUpVC = popUpController, let popUpView = popUpVC.view {
                popUpView.removeFromSuperview()
                popUpController = nil
            }
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            popUpController = storyboard.instantiateViewController(identifier: "PopUpViewController") as? PopUpViewController
            
            if let popUpView = popUpController?.view {
                popUpView.frame = firstViewController?.view.bounds ?? CGRect(x: 0, y: 0, width: 0, height: 0)
                popUpView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                firstViewController?.view.addSubview(popUpView)
                popUpController?.setupMessageView(success, message, buttonAction)
            }
        }
    }
    
    static func setLoading() {
        DispatchQueue.main.async {
            if let loadingVC = loadingController, let loadingView = loadingVC.view {
                loadingView.removeFromSuperview()
                loadingController = nil
            }
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            loadingController = storyboard.instantiateViewController(identifier: "LoadingViewController") as? LoadingViewController
            
            if let loadingView = loadingController?.view {
                loadingView.frame = firstViewController?.view.bounds ?? CGRect(x: 0, y: 0, width: 0, height: 0)
                loadingView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                firstViewController?.view.addSubview(loadingView)
                loadingController?.playAnimation()
            }
        }
    }
    
    static func stopLoading(){
        if let controller = loadingController, let controllerView = controller.view {
            DispatchQueue.main.async {
                controller.pauseAnimation()
                controllerView.removeFromSuperview()
            }
        }
    }
}

class LoadingViewController : UIViewController {
    @IBOutlet weak var loadingView: UIView!
    let animationView = AnimationView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingView.layer.cornerRadius = 10
        
        animationView.animation = Animation.named("loading")
        animationView.frame = loadingView.bounds
        animationView.backgroundColor = .clear
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        loadingView.backgroundColor = .clear
        loadingView.addSubview(animationView)
    }
    
    func playAnimation(){
        animationView.play()
        print("Animation started")
    }
    
    func pauseAnimation(){
        animationView.pause()
        print("Animation stopped")
    }
}

class PopUpViewController: UIViewController {
    
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var statusTypeImageView: UIImageView!
    @IBOutlet weak var messageLabel: UILabel!
    private var buttonAction: () -> Void = {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageView.layer.cornerRadius = 10
    }
    
    func setupMessageView(_ success: Bool, _ message: String, _ customButtonAction: @escaping ()-> Void) {
        if success {
            statusTypeImageView.image = UIImage(systemName: "checkmark.circle.fill")
            statusTypeImageView.tintColor = .green
        } else {
            statusTypeImageView.image = UIImage(systemName: "xmark.circle.fill")
            statusTypeImageView.tintColor = .red
        }
        self.messageLabel.text = message
        self.buttonAction = customButtonAction
    }
    
    @IBAction func popUpButtonClicked(_ sender: UIButton) {
        DispatchQueue.main.async {
            self.view.removeFromSuperview()
            self.dismiss(animated: true, completion: self.buttonAction)
        }
    }
}
