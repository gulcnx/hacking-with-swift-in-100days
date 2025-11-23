//
//  ContentView.swift
//  BetterRest
//
//  Created by gülçin çetin on 29.07.2025.
//

import CoreML
import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
//    @State private var alertTitle = ""
//    @State private var alertMessage = ""
//    @State private var showingAlert = false
    
    @State private var bedTime = defaultWakeTime
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }
    
    var body: some View {
        NavigationStack{
            Form{
                Section{
                    Text("When do you wanna wake up?")
                        .font(.headline)
                    DatePicker("", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }.modifier(Design())
                .onChange(of: wakeUp) {
                        calculateBedtime()
                }

                Section{
                    Text("Desired Amount of Sleep")
                        .font(.headline)
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                }.modifier(Design())
                    .onChange(of: sleepAmount) {
                            calculateBedtime()
                }

                Section{
                    Text("Daily coffee intake")
                        .font(.headline)
                    // Stepper("^[\(coffeeAmount) cup](inflect: true)", value: $coffeeAmount, in:1...20)
                    Picker(coffeeAmount == 0 ? "cup" : "cups" , selection: $coffeeAmount){
                        ForEach(1..<21){
                            Text("\($0)")
                        }
                    }
                }.modifier(Design())
                    .onChange(of: coffeeAmount) {
                            calculateBedtime()
                }

                
                Section{
                    Text("Your ideal bedtime \(bedTime.formatted(date: .omitted, time: .shortened))")
                }
                
                }
//            .alert(alertTitle, isPresented: $showingAlert){
//                Button("OK"){}
//            } message: {
//                Text(alertMessage)
//            }
            .navigationTitle("BetterRest")
//            .toolbar{
//                Button("Calculate", action: calculateBedtime)
//                    .padding()
//                    .font(.title2)
//                    .background(Color.blue)
//                    .foregroundStyle(Color.white)
//                    .clipShape(.capsule)
//            }
        }
    }
    func calculateBedtime(){
        do {
            let config =  MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
           
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            bedTime = wakeUp - prediction.actualSleep
            
//            alertTitle = "Your ideal bedtime is..."
//            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
            
        }catch{
//            alertTitle = "Error"
//            alertMessage = "Sorry, there was a problem calculating your bedtime"
        }
//        showingAlert = true
    }
    
    struct Design: ViewModifier {
        func body(content: Content) -> some View {
            content
                .padding()
        }
    }
}

#Preview {
    ContentView()
}

