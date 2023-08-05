//
//  Question.swift
//  emoji-game
//
//  Created by 徐于茹 on 2023/8/5.
//

import Foundation

struct Question {
    let topic: [String]
    let ans: [String]
    let others: [String]
    
    init(topic: [String], ans: [String]) {
        self.topic = topic
        self.ans = ans
        self.others = getRandomChineseCharacters(anser: ans)
    }
}

func getRandomChineseCharacters(anser: [String]) -> [String] {
    var allCharacters = generateRandomChineseCharacters(count: 10) + anser
    allCharacters.shuffle()
    return allCharacters
}

func generateRandomChineseCharacters(count: Int) -> [String] {
    var result: [String] = []
    
    for _ in 0..<count {
        let randomUnicodeValue = arc4random_uniform(UInt32(0x4E00 - 0x3400)) + UInt32(0x3400)
        
        if let scalar = Unicode.Scalar(randomUnicodeValue) {
            let character = Character(scalar)
            result.append(String(character))
        }
    }
    
    return result
}
