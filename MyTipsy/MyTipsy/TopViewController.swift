//
//  TopViewController.swift
//  MyTipsy
//
//  Created by 순진이 on 2022/02/17.
//

import UIKit

//리셋버튼

class TopViewController: UIViewController {
    

    let totalLabel = MyLabel(title: "💵 총 금액", size: 30) // 총금액 레이블
    let valueTextField = UITextField() // 총금액을 입력하는 텍스트필드
    let peopleLabel = MyLabel(title: "👫🏻 총 인원", size: 30) // 총인원 레이블
    let countLabel = MyLabel(title: "1", size: 30) // 총 인원수를 나타내는 레이블
    let countStepper = UIStepper() // 총인원수를 +,-하는 스텝퍼
    let calculateBtn = MyButton(title: "계산해줘", size: 40) // 계산해줘 버튼
    let dividedValue = MyLabel(title: "2", size: 50) // 계산된 금액이 표시되는 레이블
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
        
    }
}
//MARK: -UITextFieldDelegate
extension TopViewController: UITextFieldDelegate {
    // 텍스트 필드 이외의 곳 누르면 키보드 꺼지도록
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // 텍스트 필드에 숫자를 입력하면 저절로 1000단위마다 쉼표가 삽입되도록
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // replacementString : 방금 입력된 문자 하나, 붙여넣기 시에는 붙여넣어진 문자열 전체
        // return -> 텍스트가 바뀌어야 한다면 true, 아니라면 false
        // 이 메소드 내에서 textField.text는 현재 입력된 string이 붙기 전의 string
        
        
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal // 1,000,000
        formatter.locale = Locale.current
        formatter.maximumFractionDigits = 0 // 허용하는 소숫점 자리수
        
        // formatter.groupingSeparator // .decimal -> ,
        
        if let removeAllSeprator = textField.text?.replacingOccurrences(of: formatter.groupingSeparator, with: ""){
            var beforeForemattedString = removeAllSeprator + string
            if formatter.number(from: string) != nil {
                if let formattedNumber = formatter.number(from: beforeForemattedString), let formattedString = formatter.string(from: formattedNumber){
                    textField.text = formattedString
                    return false
                }
            } else { // 숫자가 아닐 때먽
                if string == "" { // 백스페이스일때
                    let lastIndex = beforeForemattedString.index(beforeForemattedString.endIndex, offsetBy: -1)
                    beforeForemattedString = String(beforeForemattedString[..<lastIndex])
                    if let formattedNumber = formatter.number(from: beforeForemattedString), let formattedString = formatter.string(from: formattedNumber){
                        textField.text = formattedString
                        return false
                    }
                } else { // 문자일 때
                    return false
                }
            }
        }
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if valueTextField.text != "" {
            return true
        } else {
            valueTextField.placeholder = "금액을 입력하세요"
            return false
        }
    }
  
//    이렇게 하면 금액 입력하자마자 금액이 사라져서 금액을 볼 수 없음
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        valueTextField.text = ""
//    }
}

//MARK: -Event
extension TopViewController {
    @objc func rightBarBtnTapped(_ sender: UIBarButtonItem) {
        valueTextField.text = ""
        countStepper.value = 0
        countLabel.text = "1"
        dividedValue.text = "0원"
    }
    
    @objc func stepperTapped(_ sender: UIStepper) {
        // 스텝퍼에서 +,-에 따라 숫자가 countLabel에 나오도록
        let senderValue = Int(sender.value)
        countLabel.text = String(senderValue)
    }
    
    
    @objc func calculateBtnTapped(_ sender: UIButton) {
        //총 금액(valueTextField)을 총인원(countLabel)으로 나누기
        if let totalValue = valueTextField.text, let totalPeople = countLabel.text {
            if let safeValue = Int(totalValue.replacingOccurrences(of: ",", with: "")) {
                let safePeople = Int(totalPeople) ?? 0
                
                // 나온 금액은 dividedValue에 나타내기
                dividedValue.text = MyTipsyBrain().getDecimalValue(safeValue, safePeople)
            }
        }
        // 계산해줘 버튼을 누른 후에는 키보드 사라지도록
        valueTextField.resignFirstResponder()
    }
}

//MARK: -UI
extension TopViewController {
    final private func configureUI() {
        setAttributes()
        addTarget()
        setConstraints()
        setUpNavBar()
        setUpRightBarButton()
    }
    
    final private func setUpRightBarButton() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "리셋", style: .plain, target: self, action: #selector(rightBarBtnTapped(_:)))
    }
    
    final private func setUpNavBar() {
        //navigationBar 색상 변경
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = MyColor.greenColor
        
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
    }
    
    final private func setAttributes() {
        //텍스트필드 설정
        valueTextField.delegate = self
        valueTextField.borderStyle = .roundedRect
        valueTextField.keyboardType = .numberPad
        
        //스텝퍼 설정
        countStepper.value = 1
        
        //계산해줘 버튼 설정
        calculateBtn.backgroundColor = MyColor.yelloColor

        //계산된 금액이 표시될 레이블 설정
        dividedValue.text = "0원"
        dividedValue.textColor = MyColor.greenColor
    }
    
    
    final private func addTarget() {
        countStepper.addTarget(self, action: #selector(stepperTapped(_:)), for: .valueChanged)
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
            
            calculateBtn.topAnchor.constraint(equalTo: peopleStack.bottomAnchor, constant: 55),
            calculateBtn.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            calculateBtn.widthAnchor.constraint(equalToConstant: 280),
            
            dividedValue.topAnchor.constraint(equalTo: calculateBtn.bottomAnchor, constant: 100),
            dividedValue.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
        ])
    }
}
