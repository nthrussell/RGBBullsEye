//
//  ContentView.swift
//  RGBBullsEye
//
//  Created by Minhajul Russell on 5/22/20.
//  Copyright © 2020 russell. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    let rTarget = Double.random(in: 0..<1)
    let gTarget = Double.random(in: 0..<1)
    let bTarget = Double.random(in: 0..<1)
    @State var rGuess: Double
    @State var gGuess: Double
    @State var bGuess: Double
    
    @State var showAlert: Bool = false
    
    @ObservedObject var timer = TimeCounter()

    var body: some View {
        
        NavigationView {
            VStack {
                HStack {
                    VStack {
                        Color(red: rTarget, green: gTarget, blue: bTarget)
                            .frame(width: 150, height: 150)
                        self.showAlert ? Text("R: \(Int(rTarget * 255)) " +
                                            "G: \(Int(gTarget * 255)) " +
                                            "B: \(Int(bTarget * 255))")
                                            : Text("Match this color")

                    }
                    
                    VStack {
                        ZStack(alignment: .center) {
                          Color(red: rGuess, green: gGuess, blue: bGuess)
                            Text(String(timer.counter))
                                .padding(.all, 5)
                                .background(Color.white)
                                .mask(Circle())
                                .foregroundColor(.black)
                    
                        }
                        .frame(width: 150, height: 150)
                        Text("R: \(Int(rGuess * 255)) " +
                             "G: \(Int(gGuess * 255)) " +
                             "B: \(Int(bGuess * 255))")
                    }
                } // HStack Ends
                
                // Button with alert
                Button(action: {
                    self.showAlert = true
                    self.timer.killTimer()
                }) {
                    Text("Hit Me!")
                }.alert(isPresented: $showAlert) {
                    Alert(title: Text("Your Score"),message: Text(String(computeScore())))
                }.padding()
                
                // Color Slider
                VStack {
                    ColorSlider(value: $rGuess , textColor: .red)
                    ColorSlider(value: $gGuess , textColor: .green)
                    ColorSlider(value: $bGuess , textColor: .blue)
                }.padding(.horizontal)
       

            } // VStack Ends
        }
        //.environment(\.colorScheme, .dark)
        
    } // body Ends
    
    func computeScore() -> Int {
        let rDiff = rGuess - rTarget
        let gDiff = gGuess - gTarget
        let bDiff = bGuess - bTarget
        let diff = sqrt(rDiff * rDiff + gDiff * gDiff + bDiff * bDiff)
        return Int((1.0 - diff) * 100.0 + 0.5)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(rGuess: 0.7, gGuess: 0.3, bGuess: 0.6)
        //.previewLayout(.fixed(width: 568, height: 320))
        //.environment(\.colorScheme, .dark)
    }
}

struct ColorSlider: View {
    @Binding var value: Double
    var textColor: Color
    
    var body: some View {
        HStack {
            Text("0").foregroundColor(textColor)
            Slider(value: $value)
                .background(textColor)
                .cornerRadius(10)
            Text("255").foregroundColor(textColor)
        }
    }
}
