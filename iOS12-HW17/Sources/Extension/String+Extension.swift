//
//  String+Extension.swift
//  iOS12-HW17
//
//  Created by Ден Майшев on 01.04.2024.
//

import UIKit

extension String {
    var digits:      String { return "0123456789" }
    var lowercase:   String { return "abcdefghijklmnopqrstuvwxyz" }
    var uppercase:   String { return "ABCDEFGHIJKLMNOPQRSTUVWXYZ" }
    var punctuation: String { return "!\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~" }
    var letters:     String { return lowercase + uppercase }
    var printable:   String { return digits + letters + punctuation }

    mutating func replace(at index: Int, with character: Character) {
        var stringArray = Array(self)
        stringArray[index] = character
        self = String(stringArray)
    }

    var containsValidCharacter: Bool {
        guard self != "" else { return true }
        let printableSet = CharacterSet(charactersIn: self.printable)
        let newSet = CharacterSet(charactersIn: self)
        return printableSet.isSuperset(of: newSet)
      }
}
