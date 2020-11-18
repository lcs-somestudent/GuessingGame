//
//  ContentView.swift
//  GuessingGame
//
//  Created by Russell Gordon on 2020-11-17.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    
    // This object named 'synthesizer', an instance of the class 'AVSpeechSynthesizer',
    // does the heavy lifting of converting text to speech
    private let synthesizer = AVSpeechSynthesizer()
    
    // This object, named 'welcomeUtterance', an instance of the class AVSpeechUtterance,
    // will store the text to be spoken aloud
    @State private var utterance = AVSpeechUtterance()
    
    // The welcome message
    private let welcome = "I'm thinking of a number between 1 and 100. Guess what it is!"
        
    // The number that the user should guess
    @State private var target = Int.random(in: 1...100)
    
    // Feedback to the user
    @State private var feedback = ""
    
    // The current guess made by the user
    @State private var theUserGuess = ""

    // The prior guess made by the user
    @State private var priorGuess = ""
    
    // Keep track of whether game is over
    @State private var gameOver = false
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                Text("\(welcome)")
                    .font(.title)
                    .padding(.bottom, 20.0)
                
                TextField("Enter your guess here",
                          text: $theUserGuess)
                    .padding(.horizontal, 25.0)
                    .font(.title)
                    .disabled(gameOver)

                Button("Check my guess") {
                    // Check the guess
                    checkGuess()
                }
                .padding(.vertical)
                .disabled(gameOver)
                
                // Only show output once input has been provided
                if priorGuess.count > 0 {
                    Text("Your last guess was \(priorGuess).")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .padding(.bottom)

                    Text("\(feedback)")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .multilineTextAlignment(.center)
                }
                
                // Only show the new game button when the current game is over
                if gameOver {
                    
                    Button("New game") {
                        // Reset the game
                        resetGame()
                    }
                    .padding(.vertical)
                    
                }
                

                Spacer()
                
            }
            .navigationTitle("Guessing Game")
            .onAppear() {
                
                // Set the phrase that will be read aloud
                utterance = AVSpeechUtterance(string: welcome)
                
                // Speak the message
                synthesizer.speak(utterance)
                
            }
            
        }
        
        
    }
    
    // Check what the user guessed against the target
    func checkGuess() {
        
        // See if the user gave us an integer in the expected range
        guard let givenInteger = Int(theUserGuess) else {
            feedback = "Please provide an integer between 1 and 100."
            return
        }
        guard givenInteger > 0, givenInteger < 101 else {
            feedback = "Please provide an integer between 1 and 100."
            return
        }
        
        // Is the guess correct?
        let range = givenInteger - target
        switch range {
        case 1...:
            feedback = "Guess lower next time."
        case 0:
            feedback = "That's correct! Well done."
            gameOver = true
        default:
            feedback = "Guess higher next time."
        }
        
        // Reset the user's guess
        priorGuess = theUserGuess
        theUserGuess = ""
        
    }
    
    // Reset the game
    func resetGame() {
        
        // Pick a new number
        target = Int.random(in: 1...100)
        
        // Reset the guess
        theUserGuess = ""
        priorGuess = ""
        
        gameOver = false
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
