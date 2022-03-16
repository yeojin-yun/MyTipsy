//
//  ViewController.swift
//  MyTipsy
//
//  Created by 순진이 on 2022/02/17.
//

import UIKit

class ViewController: UIViewController {

    let topView = UIView()
    let bottomView = UIView()
    
    let topBtn = MyButton(title: "N빵", size: 60)
    let bottomBtn = MyButton(title: "몰빵", size: 60)
    
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()

        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    

}
//MARK: -Event
extension ViewController {
    @objc func topBtnTapped(_ sender: UIButton) {
        let topVC = TopViewController()
        navigationController?.pushViewController(topVC, animated: true)
    }
    
    @objc func bottomBtnTapped(_ sender: UIButton) {
        let bottomVC = BottomViewController()
        navigationController?.pushViewController(bottomVC, animated: true)
    }
}


//MARK: -UI
extension ViewController {
    final private func configureUI() {
        setAttributes()
        addTarget()
        setConstraints()
    }
    
    final private func setAttributes() {
        topView.backgroundColor = MyColor.greenColor
        bottomView.backgroundColor = MyColor.grayColor
        
    }
    
    final private func addTarget() {
        topBtn.addTarget(self, action: #selector(topBtnTapped(_:)), for: .touchUpInside)
        bottomBtn.addTarget(self, action: #selector(bottomBtnTapped(_:)), for: .touchUpInside)
    }
    
    final private func setConstraints() {
        let stackView = UIStackView(arrangedSubviews: [topView, bottomView])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        
        [stackView, topBtn, bottomBtn].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.topAnchor.constraint(equalTo: view.topAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            topBtn.centerXAnchor.constraint(equalTo: topView.centerXAnchor),
            topBtn.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
            
            bottomBtn.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor),
            bottomBtn.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor),
        ])
    }
}
