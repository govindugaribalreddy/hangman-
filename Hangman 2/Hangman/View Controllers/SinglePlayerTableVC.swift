//
//  SinglePlayerTableVC.swift
//  Hangman
//
//  Created by Buddharaju, Pradeep on 9/28/23.
//

import UIKit

class SinglePlayerTableVC: UITableViewController {
    
    var guessWord:String?
    let dataArray = ["Easy", "Medium", "Hard"]

    override func viewDidLoad() {
        super.viewDidLoad()

        loadWordsIntoDatabase(plistName: "Easy")
        loadWordsIntoDatabase(plistName: "Medium")
        loadWordsIntoDatabase(plistName: "Hard")
    }
    
    func loadWordsIntoDatabase(plistName:String) {
        if GuesswordCRUD.read(category: plistName) == nil {
            if let URL = Bundle.main.url(forResource: plistName, withExtension: "plist") {
                if let wordsArray = NSArray(contentsOf: URL) as? [String] {
                    for word in wordsArray {
                        GuesswordCRUD.create(newWord: word, newCategory: plistName)
                    }
                }
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = dataArray[indexPath.row]

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guessWord = GuesswordCRUD.read(category: dataArray[indexPath.row])
        if let wordToDelete = guessWord {
            GuesswordCRUD.delete(oldWord: wordToDelete)
            performSegue(withIdentifier: "singleplayer2game", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "singleplayer2game" {
            if let gameVC = segue.destination as? GameVC {
                if let word = guessWord {
                    gameVC.guessWord = word
                }
            }
        }
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
