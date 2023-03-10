import Foundation

public class BundleUtils { 
    public static func getBundle(from table: StringTables?) -> Bundle {
        let map = ["Loans": "org.cocoapods.UalaLoans",
                   "Common": "org.cocoapods.UalaUI",
                   "Core": "org.cocoapods.UalaCore",
                   "Investments": "org.cocoapods.UalaInvestment",
                   "PinFlow": "org.cocoapods.UalaPinFlow",
                   "Transactions": "org.cocoapods.UalaTransactions",
                   "SignUp": "org.cocoapods.UalaSignUp",
                   "Exchange": "org.cocoapods.UalaExchange",
                   "Transfers": "org.cocoapods.UalaTransfers",
                   "AccountCharge": "org.cocoapods.UalaAccountCharge",
                   "Acquiring": "org.cocoapods.UalaAcquiring",
                   "UalaHelp": "org.cocoapods.UalaHelp",
                   "Cards": "org.cocoapods.UalaCards",
                   "Loyalty": "org.cocoapods.UalaLoyalty",
                   "Taxes": "org.cocoapods.UalaTaxCalculator",
                   "Remittances": "org.cocoapods.UalaRemittances",
                   "Insurance": "org.cocoapods.UalaInsurance",
                   "Crypto": "org.cocoapods.UalaCrypto",
                   "UalaSoftoken": "org.cocoapods.UalaSoftoken",
                   "Tracking": "org.cocoapods.UalaCardTracking",
                   "Payments": "org.cocoapods.UalaPayments",
                   "Cedears": "org.cocoapods.UalaCedears",
                   "CreditCard": "org.cocoapods.UalaCreditCard",
                   "Accounts": "org.cocoapods.UalaAccounts"]

        guard let stringTable = table?.rawValue,
              let identifier = map[stringTable],
              let tableBundle = Bundle(identifier: identifier) else { return Bundle.main }

        guard let resourceURL = tableBundle.resourceURL?.appendingPathComponent(stringTable + ".bundle"),
              let resourseBundle = Bundle(url: resourceURL) else {
            guard let resourceURL = tableBundle.resourceURL,
                  let resourseBundle = Bundle(url: resourceURL) else { return Bundle.main }
            return resourseBundle
        }
        
        return resourseBundle
    }
}
