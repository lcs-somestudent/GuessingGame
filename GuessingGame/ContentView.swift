//
//  ContentView.swift
//  GuessingGame
//
//  Created by Russell Gordon on 2020-11-17.
//

import SwiftUI

struct ContentView: View {
        
    // The number that the user should guess
    let target = Int.random(in: 1...100)
    
    // Feedback to the user
    @State private var feedback = ""
    
    // The current guess made by the user
    @State private var theUserGuess = ""

    // The prior guess made by the user
    @State private var priorGuess = ""
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                Text("I'm thinking of a number between 1 and 100. Guess what it is!")
                    .font(.title)
                    .padding(.bottom, 20.0)
                
                TextField("Enter your guess here",
                          text: $theUserGuess)
                    .padding(.horizontal, 25.0)
                    .font(.title)
                
                Button("Check my guess") {
                    // Check the guess
                    checkGuess()
                }
                .padding(.vertical)
                
                // Only show output once input has been provided
                if priorGuess.count > 0 {
                    Text("Your last guess was \(priorGuess).")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .padding(.bottom)

                    Text("\(feedback)")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .multilineTextAlignment(.center)
                }
                

                Spacer()
                
            }
            .navigationTitle("Guessing Game")
            
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
        default:
            feedback = "Guess higher next time."
        }
        
        // Reset the user's guess
        priorGuess = theUserGuess
        theUserGuess = ""
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
