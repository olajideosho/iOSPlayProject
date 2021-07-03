//
//  BaseViewController.swift
//  CreativityTrial
//
//  Created by Olajide Osho on 02/07/2021.
//

import UIKit

class BaseViewController: UIViewController, LoadingOverlayDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func isLoading(_ loading: Bool) {
        if loading {
            PopUpOverlay.setLoading()
        } else{
            PopUpOverlay.stopLoading()
        }
    }

}
