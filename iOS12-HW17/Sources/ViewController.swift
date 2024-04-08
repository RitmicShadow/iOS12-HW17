//
//  ViewController.swift
//  iOS12-HW17
//
//  Created by Ден Майшев on 01.04.2024.
//

import UIKit
import SnapKit

class ViewController: UIViewController, GeneratedPassword {

    var isBlack: Bool = true {
        didSet {
            if isBlack {
                self.view.backgroundColor = .black
            } else {
                self.view.backgroundColor = .white
            }
        }
    }

//    MARK: - UI

    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Сгенерированный пароль"
        label.font = UIFont.systemFont(ofSize: 23)
        label.textAlignment = .center
        label.textColor = .red
        return label
    }()

    private lazy var passwordTextField: UITextField = {
        let texField = UITextField()
        texField.placeholder = " Password"
        texField.backgroundColor = .systemBackground
        texField.layer.shadowOpacity = 0.4
        texField.textColor = .black
        texField.layer.cornerRadius = 14
        return texField
    }()

    private lazy var buttonGeneretedPassword: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Сгенерировать пароль", for: .normal)
        button.setTitleColor(.green, for: .normal)
        button.addTarget(self, action: #selector(generatedPassword), for: .touchUpInside)
        return button
    }()

    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Начать подбор пароля", for: .normal)
        button.setTitleColor(.green, for: .normal)
        button.addTarget(self, action: #selector(onButt), for: .touchUpInside)
        return button
    }()
    private lazy var colorChange: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Сменить цвет фона", for: .normal)
        button.setTitleColor(.green, for: .normal)
        button.addTarget(self, action: #selector(changeColor), for: .touchUpInside)
        return button
    }()

    private var stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 34
        return stack
    }()

    private lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.color = .red
        return spinner
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupHierarchy()
        setupView()
        addTapGestureToHideKeyboard()
    }

//    MARK: - Setups

    private func setupHierarchy() {
        view.addSubview(label)
        view.addSubview(stack)
        view.addSubview(spinner)
        view.addSubview(colorChange)
        stack.addArrangedSubview(passwordTextField)
        stack.addArrangedSubview(buttonGeneretedPassword)
        stack.addArrangedSubview(button)
        stack.addArrangedSubview(colorChange)
    }

    private func setupView() {
        stack.snp.makeConstraints {
            $0.top.equalTo(view.snp.centerY)
            $0.trailing.leading.equalTo(view).inset(70)
        }
        label.snp.makeConstraints {
            $0.top.equalTo(view.snp.top).inset(view.frame.size.height * 0.3)
            $0.leading.trailing.equalTo(view).inset(50)
        }
        passwordTextField.snp.makeConstraints {
            $0.height.equalTo(40)
        }
        spinner.snp.makeConstraints {
            $0.leading.equalTo(passwordTextField.snp.trailing).offset(20)
            $0.centerY.equalTo(passwordTextField)
        }
    }

    func bruteForce(passwordToUnlock: String) -> String {
        let ALLOWED_CHARACTERS: [String] = String().printable.map { String($0) }

        var password: String = ""

            while password != passwordToUnlock {
                password = generateBruteForce(password, fromArray: ALLOWED_CHARACTERS)
                DispatchQueue.main.sync { [weak self] in
                    guard let self = self else { return }
                    label.text = password
            }
        }
        return password
    }

//    MARK: - Action

    @objc
    private func onButt() {
        let text = passwordTextField.text
        var labelText = ""
        let workItem = DispatchWorkItem { [weak self] in
            guard let self = self else { return }
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    spinner.startAnimating()
                }
                labelText = bruteForce(passwordToUnlock: text ?? "")
            }

        workItem.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
            label.text = labelText
            passwordTextField.isSecureTextEntry = false
            spinner.stopAnimating()
        }
        
        DispatchQueue.global().async(execute: workItem)
    }

    @objc
    private func generatedPassword() {
        var password = ""
        passwordTextField.isSecureTextEntry = true

        for _ in 0..<2 {
            password.append(String(String().printable.randomElement() ?? Character("")))
        }
        passwordTextField.text = password
    }

    @objc
    private func changeColor() {
        isBlack.toggle()
    }
}
