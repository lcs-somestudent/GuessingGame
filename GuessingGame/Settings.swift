//
//  Settings.swift
//  GuessingGame
//
//  Created by Russell Gordon on 2020-11-18.
//

import SwiftUI
import AVFoundation

struct Settings: View {
    
    // This object named 'synthesizer', an instance of the class 'AVSpeechSynthesizer',
    // does the heavy lifting of converting text to speech
    private let synthesizer = AVSpeechSynthesizer()
    
    // This object, named 'utterance', an instance of the class AVSpeechUtterance,
    // will store the text to be spoken aloud
    @State private var utterance = AVSpeechUtterance()

    // Whether feedback will be spoken
    @Binding var speakingFeedback: Bool
    
    // Maximum value for range of random number that will be guessed
    @Binding var maximumValue: Float
    
    // What voice to use for feedback
    @Binding var voiceToUse: AVSpeechSynthesisVoice
    
    // The voice that is currently selected
    @Binding var selectedVoice: Int
    
    // The last voice selected
    @State private var lastSelectedVoice = 0
    
    // List of all available voices intended for use with the English language
    var voices = AVSpeechSynthesisVoice.speechVoices().filter { (voice) -> Bool in
        if voice.language.contains("en-") {
            return true
        } else {
            return false
        }
    }
    
    // Used to dismiss this sheet when user is finished
    @Environment(\.presentationMode) var presentationMode
        
    var body: some View {
        NavigationView {
            
            Form {
                Section(header: Text("Difficulty")) {
                    
                    VStack {
                        
                        HStack {
                            
                            Slider(value: $maximumValue,
                                   in: 2...1000,
                                   minimumValueLabel: Text("2"),
                                   maximumValueLabel: Text("1000")) {
                                
                            }
                        }
                        
                        Text("Guess values between 1 and \(Int(maximumValue)).")
                            .font(.subheadline)
                            .padding(.vertical, 5.0)
                        
                    }
                    
                    
                }
                
                Section(header: Text("Verbal Feedback")) {
                    
                    HStack {
                        Toggle("Speak Feedback", isOn: $speakingFeedback)
                    }
                    
                    Picker(selection: $selectedVoice, label: VoicePickerLabel(), content: {
                        
                        ForEach(0 ..< voices.count) { index in
                            Text(voices[index].name)
                        }
                        .navigationTitle(Text("Voice"))
                        .navigationBarTitleDisplayMode(.inline)
                        
                    })
                    // When the selected voice changes...
                    // NOTE: Also seems to fire whenever the slider value changes. 🧐
                    .onReceive([self.selectedVoice].publisher.first()) { value in
                        
                        // DEBUG
//                        print("Value is \(value)")
//                        for voice in voices {
//                            print("name is \(voice.name) and identifer is \(voice.identifier) and language is \(voice.language)")
//                        }
                        
                        // This publisher fires whenever the slider changes – so only speak the greeting when the voice actually changed due to a selection in the picker
                        if lastSelectedVoice != value {
                            
                            // Set the voice to be used
                            voiceToUse = voices[value]
                            
                            // Update the last selected voice
                            lastSelectedVoice = value
                            
                            // Provide a sample of the voice
                            let utterance = AVSpeechUtterance(string: "Nice to meet you")
                            
                            // Set the voice
                            utterance.voice = voiceToUse
                            
                            // Speak the message
                            synthesizer.speak(utterance)
                        }
                        
                    }
                    
                }
                
            }
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Done") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .listStyle(GroupedListStyle())
            
        }
        .onAppear() {
            lastSelectedVoice = selectedVoice
        }
    }
}

//struct Settings_Previews: PreviewProvider {
//    static var previews: some View {
//        Settings()
//    }
//}
