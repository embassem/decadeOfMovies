//Localized.swift

import Foundation

// swiftlint:disable superfluous_disable_command 
// swiftlint:disable file_length
// swiftlint:disable trailing_whitespace trailing_newline

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
internal enum L10n {

    internal enum OfferDetails {
        /// REDEMPTIONS CAP
        internal static var redemptionsCaps: String = {
          return L10n.tr("Localizable", "offer_details.redemptions_caps")}()
        /// 
        internal static var title: String = {
          return L10n.tr("Localizable", "offer_details.title")}()
    }

    internal enum OffersList {
        /// Title
        internal static var title: String = {
          return L10n.tr("Localizable", "offers_list.title")}()
    }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

//extension L10n {
//  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
//    let format = NSLocalizedString(key, tableName: table, comment: "")//
//    return String(format: format, locale: Locale.current, arguments: args)
//  }
//}

private final class BundleToken {}
