//
//  ViewController.swift
//  Project-5
//
//  Created by manan jain on 03/08/20.
//  Copyright © 2020 Manan Jain. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

        var allWords = [String]()
        var usedWords = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem =  UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(startGame))
        
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt"){
            if let startWordsURL = try? String(contentsOf: startWordsURL){
                allWords = startWordsURL.components(separatedBy: "\n")
            }
            
        }
        
        if allWords.isEmpty{
            allWords = [ "silkworm"]
            
        }
        
        startGame()
    }

    
  @objc func startGame(){
        title = allWords.randomElement()
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    @objc func promptForAnswer(){
        let ac = UIAlertController(title: "Enter Answer", message: nil, preferredStyle: .alert)
        ac.addTextField()
        let submitAction = UIAlertAction(title: "Submit", style: .default){
            [weak self, weak ac] _ in
            guard let answer = ac?.textFields?[0].text else {return }
            
            self?.submit(answer)
            
        }
        
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    func submit(_ answer: String){
       
            let lowerAnswer = answer.lowercased()

            if isPossible(word: lowerAnswer) {
                if isOriginal(word: lowerAnswer) {
                    if isReal(word: lowerAnswer) {
                        
                        usedWords.insert(answer.lowercased(), at: 0)
                        
                        let indexPath = IndexPath(row: 0, section: 0)
                        tableView.insertRows(at: [indexPath], with: .automatic)
                        return
                        
                    }
                    else {
                        
                        showErrorMessage(errorTitle: "Word not recognised", errorMessage: "You can't just make them up, you know! or make words with more than 2 words")
                         
                        
                    }
                } else{
                    showErrorMessage(errorTitle: "Word used already", errorMessage: "Be more original!")
                
                }
            } else{
                guard let title = title?.lowercased() else { return }
                showErrorMessage(errorTitle: "Word not possible", errorMessage: "You can't spell that word from \(title)")
                
        }
        
        }
    
    
    
    
    
    func isPossible(word: String) -> Bool {
        guard var tempWord = title?.lowercased() else { return false}
        
        for letter in word {
            if let position = tempWord.firstIndex(of: letter){
                tempWord.remove(at: position)
            } else{return false}
        }
        return true
    }
    

    func isOriginal(word: String) -> Bool {
        return !usedWords.contains(word)
    }

    func isReal(word: String) -> Bool {
            let checker = UITextChecker()
        
        let range = NSRange(location: 0, length: word.utf16.count)
        if range.length<3{
            return false
        }
        else{
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
        }
    }
    
    
    func showErrorMessage(errorTitle:String, errorMessage: String){
        let ac = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }
}

