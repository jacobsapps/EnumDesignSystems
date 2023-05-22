//
//  ButtonLibrary.swift
//  DesignSystem
//
//  Created by Jacob Bartlett on 07/05/2023.
//

import SwiftUI

struct ButtonLibrary: View {
    
    var body: some View {
        NavigationView {
            ScrollView {
                allButtons
            }
            .navigationTitle("Button Library")
        }
    }
    
    private var allButtons: some View {
        VStack {
            ForEach(buttons, id: \.self) {
                $0
                    .frame(height: 56)
                Divider()
            }
        }
        .padding(.vertical)
        .padding(.horizontal)
    }
    
    private var buttons: [MyButton] {
        MyButton.MyButtonType.allCases.flatMap { type in
            MyButton.MyButtonColor.allCases.flatMap { color in
                MyButton.MyButtonSize.allCases.flatMap { size in
                    [
                        MyButton(type: type,
                                 color: color,
                                 size: size,
                                 icon: MyButton.MyButtonIcon.leading(.Icon.profile),
                                 title: "\(type.rawValue.capitalized) \(color.rawValue.capitalized) \(size.rawValue.capitalized) Leading",
                                 action: {}),
                        
                        MyButton(type: type,
                                 color: color,
                                 size: size,
                                 title: "\(type.rawValue.capitalized) \(color.rawValue.capitalized) \(size.rawValue.capitalized)",
                                 action: {}),
                        
                        MyButton(type: type,
                                 color: color,
                                 size: size,
                                 icon: MyButton.MyButtonIcon.trailing(.Icon.profile),
                                 title: "\(type.rawValue.capitalized) \(color.rawValue.capitalized) \(size.rawValue.capitalized) Trailing",
                                 action: {})
                    ]
                }
            }
        }
    }
}

struct ComponentLibrary_Previews: PreviewProvider {
    static var previews: some View {
        ButtonLibrary()
    }
}
