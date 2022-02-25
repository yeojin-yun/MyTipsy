//
//  BottomViewController.swift
//  MyTipsy
//
//  Created by 순진이 on 2022/02/17.
//

import UIKit

class BottomViewController: UIViewController {
    
    let tableView = UITableView()
    let textField = UITextField() // 참여자 이름 입력
    let inputBtn = UIButton() // 참여자 입력 버튼
    let randomBtn = MyButton(title: "누가 낼래?", size: 40)
    let resultLbl = MyLabel(title: "윤여진", size: 50) // 몰빵 대상자 레이블
    
    
    var peopleArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setNotification()
        view.backgroundColor = .white
        textField.delegate = self
    }
    
    
}

//MARK: -UITableViewDelegate, UITableViewDataSource
extension BottomViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peopleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UITableViewCell
        cell.textLabel?.text = peopleArray[indexPath.row]
        cell.textLabel?.font = UIFont(name: "SongMyung-Regular", size: 20)
        return cell
    }
}

//MARK: -UITextFieldDelegate
extension BottomViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

//MARK: -Event
extension BottomViewController {
    @objc func inputBtnTapped(_ sender: UIButton) {
        let people = textField.text ?? ""
        peopleArray.append(people)
        textField.text = ""
        tableView.reloadData()
        //textField.endEditing(true)
    }
    
    @objc func randomBtnTapped(_ sender: UIButton) {
        let randomPerson = peopleArray.randomElement() ?? ""
        resultLbl.text = randomPerson
        textField.endEditing(true)
    }
}

//MARK: -UITextField Notificationcenter
extension BottomViewController {
    func setNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ sender: Notification) {
//                self.view.frame.origin.y = -150
        if let keyboardFrame = sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue{
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            self.view.frame.origin.y -= keyboardHeight
        }
    }
    
    @objc func keyboardWillHide(_ sender: Notification) {
        //        self.view.frame.origin.y = 0
        if let keyboardFrame = sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue{
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            self.view.frame.origin.y += keyboardHeight
        }
    }
}

//MARK: -UI
extension BottomViewController {
    final private func configureUI() {
        setAttributes()
        addTarget()
        setConstraints()
        setUpNavBar()
        setTableView()
        
    }
    

    
    func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.rowHeight = 40
    }
    
    func setUpNavBar() {
        //navigationController?.navigationBar.backgroundColor = UIColor(named: K.BrandColors.blue)
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = MyColor.grayColor
        
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
    }
    
    final private func setAttributes() {
        inputBtn.setTitle("입력", for: .normal)
        inputBtn.titleLabel?.font = UIFont(name: "SongMyung-Regular", size: 30)
        inputBtn.setTitleColor(.black, for: .normal)
        textField.borderStyle = .roundedRect
        textField.placeholder = "몰빵 후보 적고, 입력 누르기"
        textField.autocorrectionType = .no
        randomBtn.backgroundColor = MyColor.yelloColor
        resultLbl.textColor = MyColor.greenColor
    }
    
    final private func addTarget() {
        inputBtn.addTarget(self, action: #selector(inputBtnTapped(_:)), for: .touchUpInside)
        randomBtn.addTarget(self, action: #selector(randomBtnTapped(_:)), for: .touchUpInside)
    }
    
    final private func setConstraints() {
        let inputStack = UIStackView(arrangedSubviews: [textField, inputBtn])
        inputStack.axis = .horizontal
        inputStack.spacing = 20
        
        [tableView, inputStack, randomBtn, resultLbl].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -325),
            
            inputStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            inputStack.topAnchor.constraint(equalTo: tableView.bottomAnchor),
            inputStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            
            
            randomBtn.topAnchor.constraint(equalTo: inputStack.bottomAnchor, constant: 60),
            randomBtn.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            randomBtn.widthAnchor.constraint(equalToConstant: 200),
            
            resultLbl.topAnchor.constraint(equalTo: randomBtn.bottomAnchor, constant: 60),
            resultLbl.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
            
        ])
    }
}

