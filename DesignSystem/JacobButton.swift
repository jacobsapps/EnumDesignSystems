//
//  JacobButton.swift
//  DesignSystem
//
//  Created by Jacob Bartlett on 07/05/2023.
//

import SwiftUI

public struct JacobButton: View {
    
    // MARK: - Button Type -
    
    public enum ButtonType: String, CaseIterable {
        
        case primary
        case secondary
        case tertiary
        
        var mainColor: Color {
            switch self {
            case .primary: return .blue
            case .secondary: return .cyan
            case .tertiary: return .teal
            }
        }
        
        var detailColor: Color {
            switch self {
            case .primary: return .white
            case .secondary: return .white
            case .tertiary: return .white
            }
        }
    }
    
    // MARK: - Button Style -
    
    public enum ButtonStyle: String, CaseIterable {
        case filled
        case bordered
        case text
    }
    
    // MARK: - Button Size -
    
    public enum ButtonSize: String, CaseIterable {
        
        case large
        case small
        
        var height: CGFloat {
            switch self {
            case .large: return 48
            case .small: return 42
            }
        }
        
        var iconSize: CGFloat {
            switch self {
            case .large: return 22
            case .small: return 18
            }
        }
        
        var borderWidth: CGFloat {
            switch self {
            case .large: return 2
            case .small: return 1
            }
        }
    }
    
    // MARK: - Button Icon -
    
    public enum ButtonIcon {
        case leading(_ icon: Image?)
        case trailing(_ icon: Image?)
    }
    
    // MARK: - Properties -
    
    private let type: ButtonType
    private let style: ButtonStyle
    private let size: ButtonSize
    private let icon: ButtonIcon?
    private let title: String
    private let action: () -> Void
    
    // MARK: - Init -
    
    public init(type: ButtonType,
                style: ButtonStyle = .filled,
                size: ButtonSize = .large,
                icon: ButtonIcon? = nil,
                title: String,
                action: @escaping () -> Void) {
        
        self.type = type
        self.style = style
        self.size = size
        self.icon = icon
        self.title = title
        self.action = action
    }
    
    // MARK: - Body -
    
    public var body: some View {
        Button(action: action, label: {
            buttonForStyle
        })
    }
    
    @ViewBuilder
    private var buttonForStyle: some View {
        switch style {
        case .filled:
            filledButton
        case .bordered:
            borderedButton
        case .text:
            textButton
        }
    }
    
    private var textButton: some View {
        buttonContent
            .foregroundColor(type.mainColor)
            .frame(height: size.height)
            .contentShape(Rectangle())
    }
    
    @ViewBuilder
    private var borderedButton: some View {
        buttonContent
            .foregroundColor(type.mainColor)
            .frame(height: size.height)
            .buttonBorder(borderColor: type.mainColor, size: size)
    }
    
    @ViewBuilder
    private var filledButton: some View {
        buttonContent
            .foregroundColor(type.detailColor)
            .frame(height: size.height)
            .buttonBackground(fillColor: type.mainColor)
    }
    
    private var buttonContent: some View {
        HStack(spacing: 8) {
            if case .leading(let image) = icon,
               let image = image {
                iconView(for: image)
            }
            
            Text(title)
                .applyFontStyle(for: size)
            
            if case .trailing(let image) = icon,
               let image = image {
                iconView(for: image)
            }
        }
    }
    
    private func iconView(for image: Image) -> some View {
        image
            .renderingMode(.template)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: size.iconSize, height: size.iconSize)
    }
}

// MARK: - View Extensions -

private extension View {
    
    @ViewBuilder
    func applyFontStyle(for size: JacobButton.ButtonSize) -> some View {
        switch size {
        case .large:
            self.font(.system(size: 17, weight: .semibold))
        case .small:
            self.font(.system(size: 15, weight: .semibold))
        }
    }
    
    func buttonBackground(fillColor: Color) -> some View {
        self.frame(maxWidth: .infinity)
            .background(
                Capsule()
                    .fill(fillColor)
            )
    }
    
    func buttonBorder(borderColor: Color, size: JacobButton.ButtonSize) -> some View {
        self.frame(maxWidth: .infinity)
            .background(
                Capsule()
                    .stroke(borderColor, lineWidth: size.borderWidth)
            )
    }
}

extension JacobButton: Hashable {
    
    public static func == (lhs: JacobButton, rhs: JacobButton) -> Bool {
        lhs.type == rhs.type && lhs.style == rhs.style && lhs.size == rhs.size && lhs.title == rhs.title
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(type)
        hasher.combine(style)
        hasher.combine(size)
        hasher.combine(title)
    }
}
