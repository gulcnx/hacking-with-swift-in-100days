//
//  ContentView.swift
//  conversion
//
//  Created by gülçin çetin on 9.07.2025.
//

import SwiftUI

struct ContentView: View {
    @State private var inputUnit = "day"
    @State private var outputUnit = "hour"
    @State private var number = 0
    
    let inputUnits = ["second","minute","hour","day"]
    let outputUnits = ["second","minute","hour","day"]
    
    func convertToSeconds(value: Int, unit: String) -> Int{
        if unit == "minute" {
            return 60 * value
        }else if unit == "hour"{
            return 3600 * value
        }else if unit == "second"{
            return value
        }else{
            return 86400 * value
        }
    }
    
    func convertFromSeconds(value: Int, unit: String) -> Int{
        if unit == "minute"{
            return value / 60
        }else if unit == "hour"{
            return value / 3600
        }else if unit == "second"{
            return value
        }else{
            return value / 86400
        }
    }
    
    var computing: Int{
        let seconds = convertToSeconds(value: number, unit: inputUnit)
        return convertFromSeconds(value: seconds, unit: outputUnit)
    }

    var body: some View{
        NavigationStack{
            Form{
                Section("number value"){
                    TextField("enter the number",value: $number, format: .number)
                }
                Section{
                    Picker("pick input unit", selection: $inputUnit){
                        ForEach(inputUnits, id: \.self){
                            Text("\($0)")
                        }
                    }
                }
                Section{
                    Picker("pick output unit", selection: $outputUnit){
                        ForEach(outputUnits, id: \.self){
                            Text("\($0)")
                        }
                    }
                }
            }
            Form{
            Section("result"){
                Text("\(computing)")
                    }}
            .navigationTitle("Let's convert!")
        }
    }
}

#Preview {
    ContentView()
}
