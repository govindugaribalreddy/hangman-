//
//  GameVC.swift
//  Hangman
//
//  Created by Buddharaju, Pradeep on 9/14/23.
//

import UIKit

class GameVC: UIViewController {
    
    var guessWord = ""
    var curGuessCount = 0

    @IBOutlet weak var imgViewHangman: UIImageView!
    
    @IBOutlet var btnCollection: [UIButton]!
    @IBOutlet weak var lblGuessWord: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        lblGuessWord.text = guessWord
        
        createHiddenWord()

    }
    
    func createHiddenWord() {
        var hiddenWord = ""
        for _ in guessWord {
            hiddenWord = hiddenWord + "-"
        }
        lblGuessWord.text = hiddenWord
    }
    
    func showAlert(title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Done", style: UIAlertAction.Style.default, handler: { _ in
            self.navigationController?.popViewController(animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func updateWord(revealLetter:String) {
        if guessWord.contains(revealLetter) {
            var hiddenWord = lblGuessWord.text
            var counter = 0
            for ch in guessWord {
                if ch == Array(revealLetter)[0] {
                    var chars = Array(hiddenWord!)
                    chars[counter] = Array(revealLetter)[0]
                    hiddenWord = String(chars)
                }
                counter = counter + 1
            }
            lblGuessWord.text = hiddenWord
            
            if hiddenWord == guessWord {
                showAlert(title: "Win", message: "Congratulations, You won!")
            }
        }
        else {
            curGuessCount = curGuessCount + 1
            
            if curGuessCount <= 10 {
                imgViewHangman.image = UIImage(named: String(curGuessCount))
            }
            else {
                showAlert(title: "Lost", message: "Sorry, You lost! The word is " + guessWord)
            }
        }
    }
    

    
    @IBAction func btnAction(_ sender: Any) {
        let btn = sender as! UIButton
        btn.isEnabled = false
        updateWord(revealLetter: btn.titleLabel!.text!.lowercased())
        
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
