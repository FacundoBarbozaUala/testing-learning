//
//  UalaDarkTheme.swift
//  UalaFareUI
//
//  Created by Matías Schwalb on 01/09/2022.
//

import UIKit

final class DarkTheme: Theme {
    private let buttonThemeProvider: ButtonThemeProvider
    private let typographyProvider: ThemeTypographyProvider
    private let textFieldThemeProvider: TextFieldsThemeProvider
    private let inputHelperThemeProvider: InputHelperThemeProvider
    private let inputsThemeProvider: InputsThemeProvider
    private let dynamicInfoCellModelProvider: UIFareCellModelProvider
    private let tabBarViewControllerThemeFactory: UIFareTabBarControllerThemeFactory

    init(buttonThemeProvider: ButtonThemeProvider = DefaultButtonThemeProvider(),
         typographyProvider: ThemeTypographyProvider = DefaultThemeTypographyProvider(),
         textFieldThemeProvider: TextFieldsThemeProvider = DefaultTextFieldsThemeProvider(),
         inputHelperThemeProvider: InputHelperThemeProvider = DefaultInputHelperThemeProvider(),
         inputTextThemeProvider: InputsThemeProvider = DefaultInputsThemeProvider(),
         dynamicInfoCellModelProvider: UIFareCellModelProvider = DefaultUIFareCellModelProvider(),
         tabBarViewControllerThemeFactory: UIFareTabBarControllerThemeFactory = DefaultUIFareTabBarControllerThemeFactory()) {
        self.buttonThemeProvider = buttonThemeProvider
        self.typographyProvider = typographyProvider
        self.textFieldThemeProvider = textFieldThemeProvider
        self.inputHelperThemeProvider = inputHelperThemeProvider
        self.inputsThemeProvider = inputTextThemeProvider
        self.dynamicInfoCellModelProvider = dynamicInfoCellModelProvider
        self.tabBarViewControllerThemeFactory = tabBarViewControllerThemeFactory
    }
    
    func globalColor(for color: GlobalColors) -> UIColor {
        return color.color
    }
    
    public func themedHex(for color: ThemedColors) -> String {
        return DarkThemeColors.hex(for: color)
    }
    
    func color(for color: ThemedColors) -> UIColor {
        return DarkThemeColors.color(for: color)
    }
    
    func spacing(for spacing: Spacings) -> CGFloat {
        spacing.value
    }
    
    func addShadow(to view: UIView) { }
    
    func borderWidth(border: BorderWidth) -> BorderWidth {
        border
    }
    
    func addCornerRadius(to view: UIView) { }
    
    func toggleThemedModel() -> UIFareSwitchModel {
        DefaultUIFareSwitchModel(onColor: color(for: .primaryDefault),
                    offColor: color(for: .neutralMiddle),
                    disabledOnColor: color(for: .primaryLight),
                    disabledOffColor: color(for: .neutralLight),
                    thumbColor: color(for: .neutralWhite))
    }
    
    func buttonTheme(for type: UIFareButtonType) -> ButtonTheme {
        buttonThemeProvider.theme(for: type, typographyProvider: typographyProvider, theme: self)
    }
    
    func tagThemedModel(status: UIFareTagStatus, size: ComponentSize) -> UIFareTagModel {
        let labelColor: UIColor
        let backgroundColor: UIColor
        let edgeInsets: UIEdgeInsets
        
        switch status {
        case .new:
            backgroundColor = self.color(for: .accentLight)
            labelColor = self.color(for: .accentDark)
        case .ongoing:
            backgroundColor = self.color(for: .informationLight)
            labelColor = self.color(for: .informationMiddle)
        case .positive:
            backgroundColor = self.color(for: .successLight)
            labelColor = self.color(for: .successDark)
        case .negative:
            backgroundColor = self.color(for: .errorLight)
            labelColor = self.color(for: .errorDark)
        case .pending:
            backgroundColor = self.color(for: .neutralLight)
            labelColor = self.color(for: .neutralDarker)
        }
        
        switch size {
        case .small:
            edgeInsets = UIEdgeInsets(top: 5,
                                      left: 4,
                                      bottom: 4,
                                      right: 5)
        default:
            edgeInsets = UIEdgeInsets(top: 8,
                                      left: 8,
                                      bottom: 8,
                                      right: 8)
        }
        
        return DefaultTagTheme(backgroundColor: backgroundColor,
                               typographyStyle: .buttonMdRegular,
                               cornerRadius: 8,
                               textColor: labelColor,
                               edgeInsets: edgeInsets)
    }
    
    func textFieldTheme(placeholder: String?, rightIcon: Icon?, leftIcon: Icon?) -> TextFieldTheme {
        return textFieldThemeProvider.textFieldTheme(theme: self, placeholder: placeholder, rightIcon: rightIcon, leftIcon: leftIcon)
    }
    
    func amountFieldTheme(fieldType: AmountFieldType, currencySymbol: String, currencyLocaleIdentifier: String) -> AmountFieldTheme {
        return textFieldThemeProvider.amountFieldTheme(theme: self, fieldType: fieldType, currencySymbol: currencySymbol, currencyLocaleIdentifier: currencyLocaleIdentifier)
    }
    
    func codeFieldTheme(length: Int, keyboardType: UIKeyboardType, isSecureText: Bool) -> CodeFieldTheme {
        return textFieldThemeProvider.codeFieldTheme(theme: self, length: length, keyboardType: keyboardType, isSecureText: isSecureText)
    }
    
    func inputHelperTheme() -> InputHelperTheme {
        return inputHelperThemeProvider.theme()
    }
    
    func inputTextTheme(title: String?, helperText: String?, helperType: InputHelperType?, placeholder: String?, rightIcon: Icon?, leftIcon: Icon?) -> InputTextTheme {
        var inputTitle: InputTitle? = nil
        if let title = title {
            inputTitle = InputTitle(titleTypography: .labelSmRegular,
                                    title: title,
                                    titleDisabledColor: color(for: .neutralMiddle),
                                    titleDefaultColor: color(for: .primaryDefault),
                                    titleErrorColor: color(for: .errorMiddle))
        }
        
        return inputsThemeProvider.inputTextTheme(InputTextThemeParameters(helperTheme: inputHelperTheme(),
                                                                           textFieldTheme: textFieldTheme(placeholder: placeholder,
                                                                                                          rightIcon: rightIcon,
                                                                                                          leftIcon: leftIcon),
                                                                           title: inputTitle,
                                                                           helperText: helperText,
                                                                           helperType: helperType))
    }
    
    func inputAmountTheme(title: String?, fieldType: AmountFieldType, helperText: String?, helperType: InputHelperType?, currencySymbol: String, currencyLocaleIdentifier: String) -> InputAmountTheme {
        var inputTitle: InputTitle? = nil
        if let title = title {
            inputTitle = InputTitle(titleTypography: .labelSmRegular,
                                    title: title,
                                    titleDisabledColor: color(for: .neutralMiddle),
                                    titleDefaultColor: color(for: .primaryDefault),
                                    titleErrorColor: color(for: .errorMiddle))
        }
        
        return inputsThemeProvider.inputAmountTheme(InputAmountThemeParameters(helperTheme: inputHelperTheme(),
                                                                               amountFieldTheme: amountFieldTheme(fieldType: fieldType,
                                                                                                                  currencySymbol: currencySymbol,
                                                                                                                  currencyLocaleIdentifier: currencyLocaleIdentifier),
                                                                               title: inputTitle,
                                                                               helperText: helperText,
                                                                               helperType: helperType))
    }
    
    func inputCodeField(length: Int, keyboardType: UIKeyboardType, isSecureText: Bool, helperText: String?, helperType: InputHelperType?) -> InputCodeTheme {
        return inputsThemeProvider.inputCodeField(codeFieldTheme: codeFieldTheme(length: length, keyboardType: keyboardType, isSecureText: isSecureText), helperTheme: inputHelperTheme(), helperText: helperText, helperType: helperType)
    }
    
    func radioButtonTheme() -> UIFareRadioButtonModel {
        return DefaultRadioButtonTheme(selectedStateBackgroundColor: color(for: .primaryDefault),
                                       selectedStateDotColor: color(for: .neutralLighter),
                                       selectedStateBorderColor: .clear,
                                       deselectedStateDotColor: .clear,
                                       deselectedStateBorderColor: color(for: .neutralMiddle),
                                       deselectedStateBackgroundColor: color(for: .neutralLighter),
                                       disabledDeselectedStateDotColor: .clear,
                                       disabledDeselectedStateBorderColor: color(for: .neutralLight),
                                       disabledDeselectedStateBackgroundColor: color(for: .neutralLighter),
                                       disabledSelectedStateDotColor: color(for: .neutralLighter),
                                       disabledSelectedStateBorderColor: .clear,
                                       disabledSelectedStateBackgroundColor: color(for: .neutralLight))
    }
    
    func checkboxTheme() -> UIFareCheckboxModel {
        return DefaultUIFareCheckboxModel(unselectedBackgroundColor: color(for: .neutralWhite),
                                    selectedBackgroundColor: color(for: .primaryDefault),
                                    unselectedBorderColor: color(for: .neutralMiddle),
                                    selectedBorderColor: .clear,
                                    iconTintColor: color(for: .neutralWhite),
                                    disabledSelectedBackgroundColor: color(for: .neutralMiddle),
                                    disabledBorderColor: color(for: .neutralLight),
                                    icon: UIImage(withName: "check") ?? UIImage())
    }
    
    func themedDynamicInformationCellModel(for type: UIFareCellType) -> UIFareCellModel {
        dynamicInfoCellModelProvider.model(theme: self, typographyProvider: typographyProvider, type: type)
    }
    
    func cardTheme(cardType: UIFareCardType) -> UIFareCardModel {
        return MainThemeManager.shared.cardTheme(cardType: cardType)
    }
    
    func tabBarControllerTheme() -> UIFareTabBarControllerTheme {
        return tabBarViewControllerThemeFactory.tabBarControllerTheme(theme: self)
    }
    
    func navigationBarAppearance(barType: NavigationBarType) -> NavigationBarAppearance {
        switch barType {
        case .home:
            return DefaultHomeNavigationBarAppearance(backgroundColor: color(for: .primaryDefault),
                                                      iconTintColor: color(for: .neutralWhite),
                                                      titleTextColor: color(for: .neutralWhite),
                                                      titleTyphography: .titleLg)
            
        case .darkBackground:
            return DefaultHomeNavigationBarAppearance(backgroundColor: color(for: .primaryDefault),
                                                      iconTintColor: color(for: .neutralWhite),
                                                      titleTextColor: color(for: .neutralWhite),
                                                      titleTyphography: .headingSm)
            
        case .lightBackground:
            return DefaultHomeNavigationBarAppearance(backgroundColor: .clear,
                                                      iconTintColor: color(for: .neutralDark),
                                                      titleTextColor: color(for: .neutralDarker),
                                                      titleTyphography: .headingSm)
        }
    }
}
