//
//  Voices.swift
//  GuessingGame
//
//  Created by Russell Gordon on 2020-11-18.
//

import SwiftUI
import AVFoundation

struct Voices: View {
    var body: some View {
        
        List(AVSpeechSynthesisVoice.speechVoices(),
             id: \.self) { voice in
            
            Text("\(voice.name)")
            
        }
        .navigationTitle("Voice")
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

struct Voices_Previews: PreviewProvider {
    static var previews: some View {
        Voices()
    }
}
