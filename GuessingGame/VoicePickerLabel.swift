//
//  VoicePickerLabel.swift
//  GuessingGame
//
//  Created by Russell Gordon on 2020-11-18.
//

import SwiftUI

struct VoicePickerLabel: View {
    
    var body: some View {
        HStack {
            
            Image(systemName: "person.fill.questionmark")
                .resizable()
                .scaledToFit()
                // Sets the frame for the image
                .frame(width: 20, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                // Sets the frame for the background
                .frame(width: 30, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                // Sets the background color
                .background(Color.blue)
                // Gives the background rounded edges
                .clipShape(RoundedRectangle(cornerRadius: 5))
            Text("Voice")
            Spacer()
        }

    }
}

struct VoicePickerLabel_Previews: PreviewProvider {
    static var previews: some View {
        VoicePickerLabel()
    }
}
