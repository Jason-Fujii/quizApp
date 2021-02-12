//
//  DeckOfQuestions.swift
//  QuizApp
//
//  Created by Jason Fujii on 2/11/21.
//

import Foundation

class DeckOfQuestions {
    private var currentIndex: Int = 0
    
    private var questions: [Question] = [
        FlashCardQuestion(prompt: "Structs are Value Types"),
        TrueOrFalseQuestion(prompt: "Classes are Reference Types", isTrue: true),
        TrueOrFalseQuestion(prompt: "Auto layout constraints get created automatically", isTrue: false),
        TrueOrFalseQuestion(prompt: "Android is better than IOS", isTrue: false),
        TrueOrFalseQuestion(prompt: "JS is the worst", isTrue: false),
        FreeTextAnswer(prompt: "What coding language are we using?", answer: "Swift"),
        FreeTextAnswer(prompt: "What class are we taking?", answer: "CSC690")
    ]
    
    //Computed property; Preferred over "getters" and "setters"
    var currentQuestion: Question {
        return questions[currentIndex]
    }
    
    func andvanceIndex() {
        if currentIndex + 1 < questions.count {
            currentIndex += 1
        } else {
            questions.shuffle()
            currentIndex = 0
        }
    }
}
