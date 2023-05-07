//
//  ComponentLibrary.swift
//  DesignSystem
//
//  Created by Jacob Bartlett on 07/05/2023.
//

import SwiftUI

struct ComponentLibrary: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    allButtons
                }
                .padding(.top)
                .padding(.horizontal)
            }
            .navigationTitle("Component Library")
        }
    }
    
    private var allButtons: some View {
        ForEach(buttons, id: \.self) {
            $0
            Divider()
        }
    }
    
    private var buttons: [JacobButton] {
        JacobButton.ButtonType.allCases.flatMap { type in
            JacobButton.ButtonStyle.allCases.flatMap { style in
                JacobButton.ButtonSize.allCases.flatMap { size in
                    [
                        JacobButton(type: type,
                                    style: style,
                                    size: size,
                                    icon: JacobButton.ButtonIcon.leading(.Icon.profile),
                                    title: "\(type.rawValue.capitalized) \(style.rawValue.capitalized) \(size.rawValue.capitalized) Leading",
                                    action: {}),
                        
                        JacobButton(type: type,
                                    style: style,
                                    size: size,
                                    title: "\(type.rawValue.capitalized) \(style.rawValue.capitalized) \(size.rawValue.capitalized)",
                                    action: {}),
                        
                        JacobButton(type: type,
                                    style: style,
                                    size: size,
                                    icon: JacobButton.ButtonIcon.trailing(.Icon.profile),
                                    title: "\(type.rawValue.capitalized) \(style.rawValue.capitalized) \(size.rawValue.capitalized) Trailing",
                                    action: {})
                    ]
                }
            }
        }
    }
    
    private var iconTypes: [JacobButton.ButtonIcon?] {
        [
            JacobButton.ButtonIcon.leading(.Icon.profile),
            nil,
            JacobButton.ButtonIcon.trailing(.Icon.profile)
        ]
    }
}

struct ComponentLibrary_Previews: PreviewProvider {
    static var previews: some View {
        ComponentLibrary()
    }
}
