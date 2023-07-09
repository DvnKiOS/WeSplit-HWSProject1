//
//  ContentView.swift
//  weSplit
//
//  Created by Devin King on 7/8/21.
//

import SwiftUI // tells swift to import the swiftUI Framework

struct ContentView: View { // -> Creates a new structure called contentview that is going to be forced to conform to the view protocol. View comes from SwiftUI and is needed if you want to put anything on screen.
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let finalTipvalue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + finalTipvalue
        let amountPerPerson = grandTotal / peopleCount
        return amountPerPerson
    }
    var checkTotal: Double {
        let checkPrice = checkAmount
        let tipAmount = Double(tipPercentage)
        let finalcheck = checkPrice + tipAmount
        return finalcheck
    }
    
    var currentLocation: FloatingPointFormatStyle<Double>.Currency {
       
        
        return .currency(code: Locale.current.currency?.identifier ?? "USD")
    }
    
    //since we want this value to be able to hold a vlaue we are going to mark it with state. a property wrapper that is going to allow us to hold a value within this particilar variable.
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .keyboardType(.decimalPad)
                    .focused($amountIsFocused)
                    
                    Picker("Number of people", selection:  $numberOfPeople) {
                        ForEach (2..<100) {
                            Text("\($0) people")
                        }
                        
                    }
                    
                    
                }
                Section {
                    Picker("Tip Percentage", selection:  $tipPercentage) {
                        ForEach(0..<101, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                
                } header: {
                    Text("How much tip do you want to leave")
                    
                        
                }
                
                Section {
                    Text(checkTotal, format: .currency(code: Locale.current.identifier))
                } header: {
                    Text("Grand Total")
                }
                Section {
                    Text(totalPerPerson, format: .currency(code: Locale.current.identifier ))
                } header: {
                    Text("Amount Per Person")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar{
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    
                    Button("Done") {
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
