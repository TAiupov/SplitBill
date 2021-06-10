//
//  ContentView.swift
//  x010 SplitBill
//
//  Created by Тагир Аюпов on 2020-12-13.
//

import SwiftUI

struct ContentView: View {
    
    @State private var billAmount = ""
    @State private var numberOfPeople = 2
    @State private var tipPercent = 2
    
    let tipPercentages = [10, 15, 20 , 25, 0]
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double (tipPercentages[tipPercent])
        
        let orderAmount = Double (billAmount) ?? 0
        
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", text: $billAmount).keyboardType(.decimalPad)
                    
                    Picker(selection: $numberOfPeople, label: Text("Number of People"), content: {
                        ForEach(2..<100) {
                            Text("\($0)")
                        }
                    })
                }
                
                    Section(header: Text("How much tip do you want to leave?"), content: {
                        Picker("Tip Percentage", selection: $tipPercent) {
                            ForEach(0..<tipPercentages.count){
                                Text("\(tipPercentages[$0])%")
                            }
                        }.pickerStyle(SegmentedPickerStyle())
                    })
                
                
                Section(header: Text("Total + Tip"), content: {
                    Text("$\(totalPerPerson, specifier: "%.2f")")
                    
                })
            }.navigationTitle("Bill $plit")
        }.gesture(DragGesture().onChanged{_ in
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)})
}
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
