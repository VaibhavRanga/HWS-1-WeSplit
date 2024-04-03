//
//  ContentView.swift
//  HWS-1-WeSplit
//
//  Created by Vaibhav Ranga on 23/03/24.
//

import SwiftUI

struct ContentView: View {
    @State private var billAmount = 0.0
    @State private var split = 4
    @State private var tipPercentage = 10
    @FocusState private var amountIsFocused: Bool
    
    private var amountPerPerson: Double {
        let splitInDouble = Double(split)
        let tipPercentageInDouble = Double(tipPercentage)
        
        let tip = (billAmount * tipPercentageInDouble) / 100
        let amountPerPerson = (billAmount + tip) / splitInDouble
        
        return amountPerPerson
    }
    let tipPercentages = [10, 15, 20, 25, 30, 0]
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Enter bill amount") {
                    TextField("Enter amount", value: $billAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                }
                
                Section("Select number of people") {
                    Picker("Select number of people", selection: $split) {
                        ForEach(2...25, id: \.self) {
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.wheel)
                }
                
                Section("Select tip percentage") {
                    Picker("", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Amount per person") {
                    Text(amountPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .foregroundStyle(tipPercentage == 0 ? Color.red : Color.primary)
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
