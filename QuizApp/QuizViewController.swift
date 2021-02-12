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
    
    

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var trueButton: UIButton!
    @IBOutlet weak var falseButton: UIButton!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    let deck = DeckOfQuestions()
    
    func displayQuestionAtCurrentIndex() {
        let question = deck.currentQuestion
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
        let question = deck.currentQuestion
        
        
        //Move logic to model
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
        deck.andvanceIndex()
        // Display question at the current index
        displayQuestionAtCurrentIndex()
    }
    
    // viewDidLoad is a lifecycle method
    override func viewDidLoad() {
        super.viewDidLoad()
        displayQuestionAtCurrentIndex()
    }



}

