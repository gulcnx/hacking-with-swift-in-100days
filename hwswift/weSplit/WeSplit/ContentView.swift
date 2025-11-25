//
//  ContentView.swift
//  WeSplit
//
//  Created by gülçin çetin on 9.07.2025.
//

import SwiftUI

struct ContentView: View {
    @State var checkAmount = 0.0
    @State var numberOfPeople = 2
    @State var tipPercentage = 20
    
    var totalCheck: Double{
        let dCheck = Double(checkAmount)
        let dtipPercentage = Double(tipPercentage)
        let total = dCheck + ((dtipPercentage * dCheck) / 100 )
        return total
    }
    var perPerson: Double{
        let people = Double(numberOfPeople)
        return totalCheck / (people + 2.0)
    }
    
    var body: some View{
        NavigationStack{
            Form{
                Section{
                    TextField("Check amount", value: $checkAmount, format: .currency(code:
                                                                                        Locale.current.currency?.identifier ?? "USD"))
                }
                Section{
                    Picker("Number of People", selection: $numberOfPeople){
                        ForEach(2..<100){
                            Text("\($0) number people")
                        }
                    }
                }
                Section{
                    Picker("What percentage tip would you like to give?", selection: $tipPercentage){
                        ForEach(0..<101){
                            Text("\($0)")
                        }
                    }
                }
                Section("Amount Per Person"){
                    Text(perPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                Section("Total Grand is"){
                    Text(checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                .navigationTitle("WeSplit")
            }
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
