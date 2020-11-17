//
//  ContentView.swift
//  GuessingGame
//
//  Created by Russell Gordon on 2020-11-17.
//

import SwiftUI

struct ContentView: View {
    
    // The guess made by the user
    @State private var theUserGuess = ""
    
    // The number that the user should guess
    let target = Int.random(in: 1...100)
    
    // Feedback to the user
    @State private var feedback = ""
    
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
                if theUserGuess.count > 0 {
                    Text("You guessed \(theUserGuess)")
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
        feedback = "You made a guess."
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
