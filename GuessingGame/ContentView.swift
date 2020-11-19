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
    
    // This object, named 'utterance', an instance of the class AVSpeechUtterance,
    // will store the text to be spoken aloud
    @State private var utterance = AVSpeechUtterance()
    
    // What voice to use for speech
    @State private var voiceToUse: AVSpeechSynthesisVoice = AVSpeechSynthesisVoice(identifier: "com.apple.ttsbundle.Samantha-compact")!
    
    // The position of the Samantha voice in the list of voices for use with English, when sorted
    // NOTE: This is not awesome 
    @State private var selectedVoice: Int = 12
    
    // The welcome message
    @State private var welcome = ""
        
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
    
    // Whether to show a sheet for controlling settings
    @State private var showingSettings = false
    
    // Whether to speak feedback
    @State private var speakingFeedback = true

    // Maximum value for range of guesses
    @State private var maximumValue: Float = 100
    @State private var priorMaximumValue: Float = 100
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                Text("\(welcome)")
                    .font(.title)
                    .padding(.bottom, 20.0)
                    .foregroundColor(gameOver ? .secondary : .primary)
                
                TextField("Enter your guess here",
                          text: $theUserGuess)
                    .padding(.horizontal, 25.0)
                    .font(.title)
                    .disabled(gameOver)
                    .keyboardType(.numberPad)

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
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    
                    Button(action: {
                        showingSettings = true
                    }, label: {
                        Image(systemName: "gearshape")
                    })
                    
                }
            }
            .onAppear() {
                
                // Set the welcome value
                welcome = "I'm thinking of a number between 1 and \(Int(maximumValue)). Guess what it is!"

                // Speak the welcome message
                say(message: welcome)
            }
            
        }
        .sheet(isPresented: $showingSettings, onDismiss: {

            // DEBUG
//            print("maximumValue is \(maximumValue)")
//            print("are we speaking feedback? \(speakingFeedback)")

            if maximumValue != priorMaximumValue {
                
                // Set the welcome message again
                welcome = "I'm thinking of a number between 1 and \(Int(maximumValue)). Guess what it is!"
                
                // Reset the game
                resetGame()
                
                // Update prior maximum
                priorMaximumValue = maximumValue

            }
            
            
        }) {
            Settings(speakingFeedback: $speakingFeedback,
                     maximumValue: $maximumValue,
                     voiceToUse: $voiceToUse,
                     selectedVoice: $selectedVoice)
        }
        
    }
    
    // Check what the user guessed against the target
    func checkGuess() {
        
        // See if the user gave us an integer in the expected range
        guard let givenInteger = Int(theUserGuess) else {
            feedback = "Please provide an integer between 1 and \(Int(maximumValue))."
            return
        }
        guard givenInteger > 0, givenInteger < Int(maximumValue) + 1 else {
            feedback = "Please provide an integer between 1 and \(Int(maximumValue))."
            return
        }
        
        // Is the guess correct?
        let range = givenInteger - target
        switch range {
        case 1...:
            feedback = "Guess lower next time."
            say(message: "Lower")
        case 0:
            feedback = "That's correct! Well done."
            say(message: "You got it!")
            gameOver = true
        default:
            feedback = "Guess higher next time."
            say(message: "Higher")
        }
                
        // Reset the user's guess
        priorGuess = theUserGuess
        theUserGuess = ""
        
    }
    
    // Reset the game
    func resetGame() {
        
        // Pick a new number
        target = Int.random(in: 1...Int(maximumValue))
        
        // Reset the guess
        theUserGuess = ""
        priorGuess = ""
        
        // New game
        gameOver = false

        // Speak the welcome message
        say(message: welcome)
        
    }
    
    // Say something
    func say(message: String) {
        
        if speakingFeedback {

            // Set the phrase that will be read aloud
            utterance = AVSpeechUtterance(string: message)
            
            // Set the voice
            utterance.voice = voiceToUse
            
            // Speak the message
            synthesizer.speak(utterance)

        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
