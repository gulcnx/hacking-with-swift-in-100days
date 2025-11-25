//
//  ContentView.swift
//  WordScramble
//
//  Created by gülçin çetin on 31.07.2025.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    @State private var score = 0
    
    var body: some View {
            NavigationStack{
                List{
                    Text("Your score \(score)")
                    Section{
                        TextField("Enter your word", text: $newWord)
                            .textInputAutocapitalization(.never)
                    }
                    Section{
                        ForEach(usedWords, id: \.self) {word in
                            HStack{
                                Image(systemName: "\(word.count).circle")
                                Text(word)
                            }
                        }
                    }
                }
                .autocorrectionDisabled()
                .scrollContentBackground(.hidden)
                    .background(LinearGradient(stops: [
                        Gradient.Stop(color: .accentColor, location: 0.30),
                        Gradient.Stop(color: .purple, location: 0.45),
                        Gradient.Stop(color: .black, location: 0.80)
                    ], startPoint: .top, endPoint: .bottom))
                .navigationTitle(rootWord)
                    .toolbar{
                        Button("Start over", action: startGame)
                            .padding()
                            .font(.title3)
                            .background(Color.purple)
                            .foregroundStyle(.white)
                            .clipShape(.capsule)
                    }
                    .onSubmit(addNewWord)
                    .onAppear(perform: startGame)
                    .alert(errorTitle, isPresented: $showingError){
                        Button("Ok") { }
                    } message: {
                        Text(errorMessage)
                    }
            }
}
    func addNewWord() { // to use onSubmit, it must be no parameters and no return function
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard answer.count > 0 else { return }
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Word not possible", message: "You can't spell that word from \(rootWord)")
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
            return
        }
        
        guard isLongEnough(word: answer) else {
            wordError(title: "Word is too short", message: "Word must be at least 3 letters length")
            return
        }
        
        guard isItRootWord(word: answer) else {
            wordError(title: "Word is root word", message: "You can't use the root word!")
            return
        }
    
        withAnimation{
            usedWords.insert(answer, at: 0)
        }
        
        newWord = ""
    
        score = score + answer.count
    }
    
    func startGame() {
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let data = try? Data(contentsOf: startWordsURL) {
                let startWords = String(decoding: data, as: UTF8.self)
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "silkyworm"
                
                score = 0
                
                usedWords = [String]()
                
                return
            }
        }
        fatalError("Could not load the start.txt from bundle")
    }
    
    func isOriginal(word: String) -> Bool{
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord // making a copy
        
        // making a loop to see if the letter exist in our copy word
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter){
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        return true // if loop is over succesfully, return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
    
    func isLongEnough(word: String) -> Bool{
        return word.count > 2
    }
    
    func isItRootWord(word: String) -> Bool {
        return word != rootWord
    }
    
}

#Preview {
    ContentView()
}
