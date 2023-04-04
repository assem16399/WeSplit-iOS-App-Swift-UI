//
//  ContentView.swift
//  WeSplit
//
//  Created by Aasem Hany on 31/03/2023.
//

import SwiftUI

struct ContentView: View {
    let students = ["Harry","Hermione","Ron"]
    
    @State private var checkAmount = 0.0

    @State private var noOfPeopleIndex = 0
    @State private var tipPercentage = 20
    @FocusState private var isAmountFocus:Bool
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var tipAmount:Double{
        (checkAmount * Double(tipPercentage))/100
    }
    var totalPerPerson: Double{
        (checkAmount + tipAmount)/Double((2+noOfPeopleIndex))
    }
    
    let currencyFormatter:FloatingPointFormatStyle<Double>.Currency = .currency(code: Locale.current.currencyCode ?? "USD")
    
    var body: some View{
        
        NavigationView
        {
            Form{
                Section{
                   TextField("Amount", value: $checkAmount, format: currencyFormatter)
                        .keyboardType(.decimalPad)
                        .focused($isAmountFocus)
                    
                    Picker("Select number of people", selection: $noOfPeopleIndex){
                        ForEach(2..<100){
                            Text("\($0) people")
                        }
                    }
                    
                }
                
                Section(content: {
                    Picker("Choose percetage", selection: $tipPercentage){
                        ForEach(0..<100, id: \.self){
                            Text($0,format:.percent)
                        }
                    }
                }, header: {
                    Text("Tip percentage")
                }){
                    
                }
                
                Section{
                    Text(String(format: "$%0.2f", totalPerPerson))
                }header: {
                    Text("Amount per person")
                }
                
                Section{
                    Text(checkAmount+tipAmount,format: currencyFormatter)
                }header: {
                    Text("Total amount")
                }
            }.navigationTitle("WeSplit")
                .toolbar{
                    
                    ToolbarItemGroup(placement: .keyboard){
                        Spacer()
                            .background(.red)
                        Button("Done"){
                            isAmountFocus = false
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




