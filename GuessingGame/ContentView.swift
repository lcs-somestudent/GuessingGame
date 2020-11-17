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
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                Text("Guessing Game")
                
                Text("I'm thinking of a number between 1 and 100. Guess what it is!")
                
                TextField("Enter your guess here",
                          text: $theUserGuess)
                
                Button("Submit Guess") {
                    // Check the guess
                }
                
                Text("You guessed \(theUserGuess).")
                
            }
            .navigationTitle("Guessing Game")
            
        }
        
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
