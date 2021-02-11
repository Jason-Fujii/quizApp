import UIKit

protocol Question {
    var prompt: String { get }
}

struct FlashCardQuestion: Question {
    let prompt: String
}

struct TrueOrFalseQuestion: Question {
    let prompt: String
    let isTrue: Bool
}

struct FreeTextAnswer: Question {
    let prompt: String
    let answer: String
}

class QuizViewController: UIViewController {
    
    var questions: [Question] = [
        FlashCardQuestion(prompt: "Structs are Value Types"),
        TrueOrFalseQuestion(prompt: "Classes are Reference Types", isTrue: true),
        TrueOrFalseQuestion(prompt: "Auto layout constraints get created automatically", isTrue: false),
        TrueOrFalseQuestion(prompt: "Android is better than IOS", isTrue: false),
        TrueOrFalseQuestion(prompt: "JS is the worst", isTrue: false),
        FreeTextAnswer(prompt: "What coding language are we using?", answer: "Swift"),
        FreeTextAnswer(prompt: "What class are we taking?", answer: "CSC690")
    ]

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var trueButton: UIButton!
    @IBOutlet weak var falseButton: UIButton!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    var currentIndex: Int = 0
    
    func andvanceIndex() {
        if currentIndex + 1 < questions.count {
            currentIndex += 1
        } else {
            questions.shuffle()
            currentIndex = 0
        }
    }
    
    func displayQuestionAtCurrentIndex() {
        let question = questions[currentIndex]
        questionLabel.text = question.prompt
        
        switch question {
        case is TrueOrFalseQuestion:
            trueButton.setTitle("True", for: UIControl.State.normal)
            trueButton.isHidden = false
            falseButton.isHidden = false
            textField.isHidden = true
            submitButton.isHidden = true
        case is FlashCardQuestion:
            trueButton.setTitle("Next", for: UIControl.State.normal)
            trueButton.isHidden = false
            falseButton.isHidden = true
            textField.isHidden = true
            submitButton.isHidden = true
        case is FreeTextAnswer:
            trueButton.isHidden = true
            falseButton.isHidden = true
            textField.isHidden = false
            submitButton.isHidden = false
        default: ()
        }
    }
    
    @IBAction func submitClicked(_ sender: UIButton) {
        let question: Question = questions[currentIndex]
        
        switch question {
        case let trueOrFalseQuestion as TrueOrFalseQuestion:
            let userSelectedTrue = sender.tag == 0
            let isSelectionCorrect = trueOrFalseQuestion.isTrue == userSelectedTrue
            if !isSelectionCorrect {
                let alert = UIAlertController(title: "Incorrect!", message: nil, preferredStyle: UIAlertController.Style.alert)
                let ok = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(ok)
                present(alert, animated: true, completion: nil)
            }
        case is FlashCardQuestion:
            ()
        case let textQuestion as FreeTextAnswer:
            let correct = textQuestion.answer == textField.text
            print(correct)
            if(!correct){
                //alert to say WRONG!
                let alert = UIAlertController(title: "Incorrect!", message: nil, preferredStyle: UIAlertController.Style.alert)
                let ok = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(ok)
                present(alert, animated: true, completion: nil)
            }
            textField.text = ""
        default:
            print("Could not cast to existing type")
        }
        // Advance the current index
        andvanceIndex()
        // Display question at the current index
        displayQuestionAtCurrentIndex()
    }
    
    // viewDidLoad is a lifecycle method
    override func viewDidLoad() {
        super.viewDidLoad()
        displayQuestionAtCurrentIndex()
    }



}

