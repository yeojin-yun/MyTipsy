//
//  TopViewController.swift
//  MyTipsy
//
//  Created by 순진이 on 2022/02/17.
//

import UIKit

class TopViewController: UIViewController {

    let totalLabel = MyLabel(title: "💵 총 금액", size: 30)
    let valueTextField = UITextField()
    let peopleLabel = MyLabel(title: "👫🏻 총 인원", size: 30)
    let countLabel = MyLabel(title: "2", size: 30)
    let countStepper = UIStepper()
    let calculateBtn = UIButton()
    let dividedValue = MyLabel(title: "2", size: 30)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
        
    }
}
//MARK: -UITextFieldDelegate
extension TopViewController: UITextFieldDelegate {
    // 텍스트 필드 이외의 곳 누르면 키보드 꺼지도록
    // 텍스트 필드에 숫자를 입력하면 저절로 1000단위마다 쉼표가 삽입되도록
}

//MARK: -Event
extension TopViewController {
    @objc func stepperTapped(_sender: UIStepper) {
        // 스텝퍼에서 +누르면 countLabel 숫자가 올라가고, -를 누르면 countLabel의 숫자가 내려가도록
    }
    
    @objc func calculateBtnTapped(_ sender: UIButton) {
        // 총 금액(valueTextField)을 총인원(countLabel)으로 나누기
        // 나온 금액은 dividedValue에 나타내기
    }
}

//MARK: -UI
extension TopViewController {
    final private func configureUI() {
        setAttributes()
        addTarget()
        setConstraints()
    }
    
    final private func setAttributes() {
        valueTextField.borderStyle = .roundedRect
        valueTextField.keyboardType = .numberPad
        
        [calculateBtn].forEach {
            $0.setTitle("계산해줘", for: .normal)
            $0.titleLabel?.font = UIFont(name: "SongMyung-Regular", size: 40)
            $0.backgroundColor = MyColor.yelloColor
            $0.setTitleColor(.darkGray, for: .normal)
            $0.layer.cornerRadius = 20
            $0.clipsToBounds = true
        }
        
        dividedValue.text = "5,000원"
    }
    final private func addTarget() {
        countStepper.addTarget(self, action: #selector(stepperTapped(_sender:)), for: .valueChanged)
        calculateBtn.addTarget(self, action: #selector(calculateBtnTapped(_:)), for: .touchUpInside)
    }
    
    final private func setConstraints() {
        
        let peopleStack = UIStackView(arrangedSubviews: [countLabel, countStepper])
        peopleStack.axis = .horizontal
        peopleStack.spacing = 20
        
        [totalLabel, valueTextField, peopleLabel, peopleStack, calculateBtn, dividedValue].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            totalLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 70),
            totalLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
            valueTextField.topAnchor.constraint(equalTo: totalLabel.bottomAnchor, constant: 30),
            valueTextField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            valueTextField.widthAnchor.constraint(equalToConstant: 150),
            
            peopleLabel.topAnchor.constraint(equalTo: valueTextField.bottomAnchor, constant: 50),
            peopleLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
            peopleStack.topAnchor.constraint(equalTo: peopleLabel.bottomAnchor, constant: 30),
            peopleStack.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
            calculateBtn.topAnchor.constraint(equalTo: peopleStack.bottomAnchor, constant: 100),
            calculateBtn.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            calculateBtn.widthAnchor.constraint(equalToConstant: 280),
            
            dividedValue.topAnchor.constraint(equalTo: calculateBtn.bottomAnchor, constant: 80),
            dividedValue.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
        ])
    }
}
