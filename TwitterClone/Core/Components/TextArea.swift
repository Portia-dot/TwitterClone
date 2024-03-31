//
//  TextArea.swift
//  TwitterClone
//
//  Created by Modamori Oluwayomi on 2024-03-12.
//

import SwiftUI

struct TextArea: View {
    @Binding var text: String
    let placeholder: String

    init(_ placeholder: String, text: Binding<String>) {
        self._text = text
        self.placeholder = placeholder
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            if text.isEmpty {
                Text(placeholder)
                    .foregroundColor(Color(UIColor.placeholderText))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 12)
            }
            TextEditor(text: $text)
                .padding(.horizontal, 8)
                .padding(.vertical, 12)
        }
        .font(.body)
//        .frame(minHeight: 100)
    }
}

struct TextArea_Previews: PreviewProvider {
    struct PreviewWrapper: View {
        @State private var text = ""

        var body: some View {
            TextArea("What's happening?", text: $text)
                .padding()
                .border(Color.gray, width: 1)
                .frame(maxHeight: 200)
        }
    }

    static var previews: some View {
        PreviewWrapper()
    }
}

