//
//  BottomViewController.swift
//  MyTipsy
//
//  Created by 순진이 on 2022/02/17.
//

import UIKit

class BottomViewController: UIViewController {

    let tableView = UITableView()
    let textField = UITextField()
    let inputBtn = UIButton()
    let resultLbl = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        view.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.rowHeight = 60
    }
}

//MARK: -UITableViewDelegate, UITableViewDataSource
extension BottomViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UITableViewCell
        return cell
    }
}


//MARK: -UI
extension BottomViewController {
    final private func configureUI() {
        setAttributes()
        addTarget()
        setConstraints()
    }
    
    final private func setAttributes() {
        inputBtn.setTitle("입력", for: .normal)
        inputBtn.setTitleColor(.red, for: .normal)
        resultLbl.text = "윤여진"
        textField.borderStyle = .roundedRect
    }
    
    final private func addTarget() {
        
    }
    
    final private func setConstraints() {
        let inputStack = UIStackView(arrangedSubviews: [textField, inputBtn])
        inputStack.axis = .horizontal
        inputStack.spacing = 20
        
        [tableView, inputStack, resultLbl].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -400),
            
            inputStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            inputStack.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 40),
            inputStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            resultLbl.topAnchor.constraint(equalTo: inputStack.bottomAnchor, constant: 40),
            resultLbl.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
            
        ])
    }
}

