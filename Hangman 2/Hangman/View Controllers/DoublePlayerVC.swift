//
//  DoublePlayerVC.swift
//  Hangman
//
//  Created by Buddharaju, Pradeep on 9/14/23.
//

import UIKit

class DoublePlayerVC: UIViewController {
    
    var str:String?
    
    

    @IBOutlet weak var tfGuessWord: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tfGuessWord.becomeFirstResponder()
    }
    
    @IBAction func btnMenuAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func btnPlayAction(_ sender: Any) {
        performSegue(withIdentifier: "doubleplayer2game", sender: self)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "doubleplayer2game" {
            if let gameVC = segue.destination as? GameVC {
                if let enteredText = tfGuessWord.text {
                    gameVC.guessWord = enteredText
                }
            }
        }
        
    }
    

}
