//
//  ContentView.swift
//  GuesstheFlag
//
//  Created by gülçin çetin on 12.07.2025.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = [
        "Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"
    ].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    
    @State private var questionCount = 0
    @State private var showingFinalScore = false
    
    var body: some View {
        VStack(spacing: 15) {
            ZStack {
                RadialGradient(stops: [
                    .init(color: Color(red: 0.1, green: 0.1, blue: 0.20), location: 0.3),
                    .init(color: Color(red: 0.10, green: 0.15, blue: 0.30), location: 0.3),
                ], center: .top, startRadius: 100, endRadius: 400)
                    .ignoresSafeArea()
                VStack(spacing: 30){
                        Text("Guess the flag")
                            .font(.largeTitle.weight(.bold))
                            .foregroundStyle(.white)
                    VStack{
                        Text("Tap the flag of")
                            .font(.subheadline.weight(.heavy))
                            .foregroundStyle(.white)
                        
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                            .foregroundStyle(.white)
                    }
                    ForEach(0..<3){ number in
                        Button{
                            flagTapped(number)
                        }label: {
                            Image(countries[number])
                                .clipShape(.capsule)
                                .shadow(radius: 5)
                        }
                    }
                }
            }
            .alert(scoreTitle, isPresented: $showingScore){
                Button("Continune",action: askQuestion)
            } message: {
                Text("Your score is \(score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
            }
            .alert("Final score is \(score)", isPresented: $showingFinalScore){
                Button("Restart", action: resetGame)
            } message: {
                Text("Tap to restart")
            }
        }.frame(maxWidth: .infinity)
            .padding(.vertical, 20)
            .background(.regularMaterial)
            .clipShape(.rect(cornerRadius: 20))
    }
    
    func flagTapped(_ number: Int){
        questionCount += 1
        
        if number == correctAnswer{
            scoreTitle = "Correct!"
            score += 20
        }else{
            scoreTitle = "Wrong! its the flag of \(countries[correctAnswer])."
        }
        
        if questionCount == 5 {
            showingFinalScore = true
        }else {
            showingScore = true
        }
    }
    
    func askQuestion(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    func resetGame(){
        score = 0
        questionCount = 0
        askQuestion()
        
    }
}


#Preview {
    ContentView()
}

