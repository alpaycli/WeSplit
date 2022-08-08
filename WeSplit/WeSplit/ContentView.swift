//
//  ContentView.swift
//  WeSplit
//
//  Created by Alpay Calalli on 29.06.22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var useRedText = false
    
    
    @State private var numberOfPeople = 2
    @State private var check = 0.0
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    
    var totalPerPerson: Double{
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        let tipAmount = check / 100 * tipSelection
        let grandTotal = check + tipAmount
        let amountPerPerson = grandTotal / peopleCount
        
    
        return amountPerPerson
    }
    
    var all: Double{
        let tipSelection = Double(tipPercentage)
        let tipAmount = check / 100 * tipSelection
        let checkAmount = check + tipAmount
        
        return checkAmount
        
    }

    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    TextField("Check amount" ,value:$check, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                        .focused($amountIsFocused)
                
                    Picker("Number of People", selection: $numberOfPeople){
                        ForEach(2..<100){
                            Text("\($0) people")
                    }
                }
            }
            
                Section{
                    Picker("Choose a tip percentage", selection: $tipPercentage){
                        ForEach(tipPercentages, id: \.self){
                            Text($0, format: .percent)
                        }
                    }.pickerStyle(.segmented)
                }header: {
                    Text("How much tip do you want to leave?")
                }
                
                Section{
                    Text(totalPerPerson, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                }header: {
                    Text("Amount that each person has to pay")
                }
                
                Section{
                    Text(all, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                        .foregroundColor(tipPercentage == 0 ? .red : .green)
                }header: {
                    Text("Total check")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar{
                ToolbarItemGroup(placement: .keyboard){
                    Spacer() 
                    Button("Done"){
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
