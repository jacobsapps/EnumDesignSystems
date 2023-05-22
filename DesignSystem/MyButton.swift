//
//  JacobButton.swift
//  DesignSystem
//
//  Created by Jacob Bartlett on 07/05/2023.
//

import SwiftUI

public struct MyButton: View {
    
    // MARK: - Type -
    
    public enum MyButtonType: String, CaseIterable {
        case primary
        case secondary
        case tertiary
    }
    
    // MARK: - Size -
    
    public enum MyButtonSize: String, CaseIterable {
        
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
            case .large: return 20
            case .small: return 16
            }
        }
        
        var borderWidth: CGFloat {
            switch self {
            case .large: return 2
            case .small: return 1
            }
        }
    }
    
    // MARK: - Color -
    
    public enum MyButtonColor: String, CaseIterable {
        
        case `default`
        case accent
        case error
        
        var mainColor: Color {
            switch self {
            case .`default`: return .blue
            case .accent: return .green.opacity(0.85)
            case .error: return .red.opacity(0.6)
            }
        }
        
        var detailColor: Color {
            switch self {
            case .`default`: return .white
            case .accent: return .white
            case .error: return .white
            }
        }
    }
    
    // MARK: - Icon -
    
    public enum MyButtonIcon {
        case leading(_ icon: Image)
        case trailing(_ icon: Image)
    }
    
    // MARK: - Properties -
    
    private let type: MyButtonType
    private let color: MyButtonColor
    private let size: MyButtonSize
    private let icon: MyButtonIcon?
    private let title: String
    private let action: () -> Void
    
    // MARK: - Init -
    
    public init(type: MyButtonType = .primary,
                color: MyButtonColor = .`default`,
                size: MyButtonSize = .large,
                icon: MyButtonIcon? = nil,
                title: String,
                action: @escaping () -> Void) {
        
        self.type = type
        self.color = color
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
        switch type {
        case .primary:
            filledButton
        case .secondary:
            borderedButton
        case .tertiary:
            textButton
        }
    }
    
    private var textButton: some View {
        buttonContent
            .foregroundColor(color.mainColor)
            .frame(height: size.height)
            .contentShape(Rectangle())
    }
    
    @ViewBuilder
    private var borderedButton: some View {
        buttonContent
            .foregroundColor(color.mainColor)
            .frame(height: size.height)
            .buttonBorder(borderColor: color.mainColor, size: size)
    }
    
    @ViewBuilder
    private var filledButton: some View {
        buttonContent
            .foregroundColor(color.detailColor)
            .frame(height: size.height)
            .buttonBackground(fillColor: color.mainColor)
    }
    
    private var buttonContent: some View {
        HStack(spacing: 16) {
            if case .leading(let image) = icon {
                iconView(for: image)
            }
            
            Text(title)
                .applyFontStyle(for: size)
            
            if case .trailing(let image) = icon {
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
    func applyFontStyle(for size: MyButton.MyButtonSize) -> some View {
        switch size {
        case .large:
            font(.system(size: 17, weight: .semibold))
        case .small:
            font(.system(size: 15, weight: .semibold))
        }
    }
    
    func buttonBackground(fillColor: Color) -> some View {
        frame(maxWidth: .infinity)
            .background(
                Capsule()
                    .fill(fillColor)
            )
    }
    
    func buttonBorder(borderColor: Color, size: MyButton.MyButtonSize) -> some View {
        frame(maxWidth: .infinity)
            .background(
                Capsule()
                    .stroke(borderColor, lineWidth: size.borderWidth)
            )
    }
}

// MARK: - Hashable Conformance -

/// Conforming to Hashable here so the buttons work nicely with SwiftUI's ForEach in our Button Library
///
extension MyButton: Hashable {
    
    public static func == (lhs: MyButton, rhs: MyButton) -> Bool {
        lhs.type == rhs.type && lhs.color == rhs.color && lhs.size == rhs.size && lhs.title == rhs.title
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(type)
        hasher.combine(color)
        hasher.combine(size)
        hasher.combine(title)
    }
}
