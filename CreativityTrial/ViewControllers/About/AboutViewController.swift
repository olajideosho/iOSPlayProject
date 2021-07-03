//
//  AboutViewController.swift
//  CreativityTrial
//
//  Created by Olajide Osho on 02/07/2021.
//

import UIKit

class AboutViewController: BaseViewController, AboutViewModelDelegate {
    
    var viewModel: AboutViewModel?
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    @IBOutlet weak var titleSearchTextField: UITextField!
    @IBOutlet weak var postTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = AboutViewModel(self)
        
        setupTableView()
        setupTextFields()
    }
    
    func setupTableView(){
        postTableView.delegate = self
        postTableView.dataSource = self
    }
    
    func setupTextFields(){
        idTextField.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        idTextField.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        titleTextField.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        titleSearchTextField.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        bodyTextView.delegate = self
    }
    
    @objc func textFieldEditingChanged(_ textField: UITextField) {
        if textField == idTextField {
            viewModel?.postRequest.id = Int(idTextField.text ?? "0")
        } else if textField == titleTextField {
            viewModel?.postRequest.title = titleTextField.text
        } else if textField == titleSearchTextField {
            viewModel?.getPosts(titleSearchTextField.text ?? "")
        }
    }
    
    @objc func textViewEditingChanged(_ textView: UITextView) {
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewModel?.getPosts("")
    }
    
    @IBAction func saveButtonClicked(_ sender: UIButton) {
        viewModel?.sendPost()
    }
    
    func notifyDataChanged() {
        DispatchQueue.main.async {
            self.postTableView.reloadData()
        }
    }
    
    func error(_ error: APIError) {
        PopUpOverlay.showMessage(false, error.errorMessage!) {
            print("Another Action Clicked")
        }
    }
    
    func clearFields(){
        idTextField.text = ""
        titleTextField.text = ""
        bodyTextView.text = ""
        titleSearchTextField.text = ""
    }
}

extension AboutViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if textView == bodyTextView {
            viewModel?.postRequest.body = bodyTextView.text
        }
    }
}

extension AboutViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.posts?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell") as! PostTableViewCell
        let post = viewModel?.posts?[indexPath.row]
        cell.setupCell(post ?? Post())
        return cell
    }
    
    
}
