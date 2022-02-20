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
    let countLabel = MyLabel(title: "1", size: 30)
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
            
            if let removeAllSeprator = valueTextField.text?.replacingOccurrences(of: formatter.groupingSeparator, with: ""){
                var beforeForemattedString = removeAllSeprator + string
                if formatter.number(from: string) != nil {
                    if let formattedNumber = formatter.number(from: beforeForemattedString), let formattedString = formatter.string(from: formattedNumber){
                        textField.text = formattedString
                        return false
                    }
                }else{ // 숫자가 아닐 때먽
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
}

//MARK: -Event
extension TopViewController {
    @objc func stepperTapped(_ sender: UIStepper) {
        // 스텝퍼에서 +누르면 countLabel 숫자가 올라가고, -를 누르면 countLabel의 숫자가 내려가도록
        let senderValue = Int(sender.value)
        print(senderValue)
        countLabel.text = String(senderValue)
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
        valueTextField.delegate = self
        valueTextField.borderStyle = .roundedRect
        valueTextField.keyboardType = .numberPad
        countStepper.value = 1
        
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
            
            calculateBtn.topAnchor.constraint(equalTo: peopleStack.bottomAnchor, constant: 100),
            calculateBtn.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            calculateBtn.widthAnchor.constraint(equalToConstant: 280),
            
            dividedValue.topAnchor.constraint(equalTo: calculateBtn.bottomAnchor, constant: 80),
            dividedValue.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
        ])
    }
}
