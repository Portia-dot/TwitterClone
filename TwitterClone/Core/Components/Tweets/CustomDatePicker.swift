//
//  CustomDatePicker.swift
//  TwitterClone
//
//  Created by Modamori Oluwayomi on 2024-03-30.
//

import SwiftUI

struct CustomDatePicker: View {
    var label: String
    var systemImage: String
    @Binding var selectedDate: Date
    var body: some View {
        VStack (spacing: 10){
            HStack{
                Image(systemName: systemImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundStyle(Color(.darkGray))
                
                DatePicker(label, selection: $selectedDate, displayedComponents: .date)
            }
        }
        Divider()
            .background(Color(.darkGray))
    }
}

//#Preview {
//    @State var selectedDate = Date()
//    CustomDatePicker(label: "Date", systemImage: "calendar", selectedDate: $selectedDate)
//}
