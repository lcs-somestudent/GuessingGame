//
//  Settings.swift
//  GuessingGame
//
//  Created by Russell Gordon on 2020-11-18.
//

import SwiftUI

struct Settings: View {
    
    @Binding var speakingFeedback: Bool
    @Binding var maximumValue: Float
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            
            List {
                Section(header: Text("Difficulty")) {
                    
                    VStack {
                        
                        HStack {
                            
                            Slider(value: $maximumValue,
                                   in: 2...1000,
                                   minimumValueLabel: Text("2"),
                                   maximumValueLabel: Text("1000")) {
                                
                            }
                        }
    
                        Text("You'll be guessing a value between 1 and \(Int(maximumValue)).")
                            .font(.subheadline)
                            .padding(.vertical, 5.0)

                    }
                    

                }
                
                Section(header: Text("Verbal Feedback")) {
                    
                    HStack {
                        Toggle("Speak Feedback", isOn: $speakingFeedback)
                    }
                    
                    NavigationLink(destination: Voices()) {
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
                            Text("Default")
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
    }
}

//struct Settings_Previews: PreviewProvider {
//    static var previews: some View {
//        Settings()
//    }
//}
