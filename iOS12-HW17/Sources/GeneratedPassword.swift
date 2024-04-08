//
//  GeneratedPassword.swift
//  iOS12-HW17
//
//  Created by Ден Майшев on 08.04.2024.
//

import Foundation

protocol GeneratedPassword {
    func indexOf(character: Character, _ array: [String]) -> Int
    func characterAt(index: Int, _ array: [String]) -> Character
    func generateBruteForce(_ string: String, fromArray array: [String]) -> String
}

extension GeneratedPassword {

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
}
