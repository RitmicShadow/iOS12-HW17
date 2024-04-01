//
//  ViewController.swift
//  iOS12-HW17
//
//  Created by Ден Майшев on 01.04.2024.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    var isBlack: Bool = false {
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
        let button = UIButton()
        button.setTitle("Сгенерировать пароль", for: .normal)
        button.setTitleColor(.green, for: .normal)
        button.addTarget(self, action: #selector(generatedPassword), for: .touchUpInside)
        return button
    }()

    private lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("Button", for: .normal)
        button.setTitleColor(.green, for: .normal)
        button.addTarget(self, action: #selector(onBut), for: .touchUpInside)
        return button
    }()

    private var stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 34
        return stack
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupLayout()
    }

    private func setupHierarchy() {
        view.addSubview(label)
        view.addSubview(stack)
        stack.addArrangedSubview(passwordTextField)
        stack.addArrangedSubview(buttonGeneretedPassword)
        stack.addArrangedSubview(button)
    }

    private func setupLayout() {
        stack.snp.makeConstraints {
            $0.top.equalTo(view.snp.centerY)
            $0.trailing.leading.equalTo(view).inset(50)
        }
        label.snp.makeConstraints {
            $0.top.equalTo(view.snp.top).inset(view.frame.size.height * 0.3)
            $0.leading.trailing.equalTo(view).inset(50)
        }
        passwordTextField.snp.makeConstraints {
            $0.height.equalTo(40)
        }
    }

    func bruteForce(passwordToUnlock: String) {
        let ALLOWED_CHARACTERS:   [String] = String().printable.map { String($0) }

        var password: String = ""

        // Will strangely ends at 0000 instead of ~~~
        while password != passwordToUnlock { // Increase MAXIMUM_PASSWORD_SIZE value for more
            password = generateBruteForce(password, fromArray: ALLOWED_CHARACTERS)
            //             Your stuff here
//            print(password)
            // Your stuff here
        }
//        print(password)
    }

//    MARK: - Action

    @objc
    private func onBut() {
        isBlack.toggle()
    }

    @objc
    private func generatedPassword() {
        var password = ""
        passwordTextField.isSecureTextEntry = true

        for _ in 0..<4 {
            password.append(String(String().printable.randomElement() ?? Character("")))
        }
        passwordTextField.text = password
    }
}

func indexOf(character: Character, _ array: [String]) -> Int {
    return array.firstIndex(of: String(character))!
}

func characterAt(index: Int, _ array: [String]) -> Character {
    return index < array.count ? Character(array[index])
    : Character("")
}

func generateBruteForce(_ string: String, fromArray array: [String]) -> String {
    var str: String = string

    if str.count <= 0 {
        str.append(characterAt(index: 0, array))
    }
    else {
        str.replace(at: str.count - 1,
                    with: characterAt(index: (indexOf(character: str.last!, array) + 1) % array.count, array))

        if indexOf(character: str.last!, array) == 0 {
            str = String(generateBruteForce(String(str.dropLast()), fromArray: array)) + String(str.last!)
        }
    }
    return str
}
