//  Created by Keith Harrison https://useyourloaf.com
//  Copyright (c) 2017 Keith Harrison. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright
//  notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright
//  notice, this list of conditions and the following disclaimer in the
//  documentation and/or other materials provided with the distribution.
//
//  3. Neither the name of the copyright holder nor the names of its
//  contributors may be used to endorse or promote products derived from
//  this software without specific prior written permission.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
//  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
//  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
//  ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
//  LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
//  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
//  SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
//  INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
//  CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
//  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
//  POSSIBILITY OF SUCH DAMAGE.

import UIKit

/// A utility class to help you use custom fonts with
/// dynamic type.
///
/// To use this class you must supply the name of a style
/// dictionary for the font when creating the class. The
/// style dictionary should be stored as a property list
/// file in the main bundle.
///
/// The style dictionary contains an entry for each text
/// style that uses the raw string value for each
/// `UIFontTextStyle` as the key.
///
/// The value of each entry is a dictionary with two keys:
///
/// + fontName: A String which is the font name.
/// + fontSize: A number which is the point size to use
///             at the `.large` content size.
///
/// For example to use a 17 pt Noteworthy-Bold font
/// for the `.headline` style at the `.large` content size:
///
///     <dict>
///         <key>UICTFontTextStyleHeadline</key>
///         <dict>
///             <key>fontName</key>
///             <string>Noteworthy-Bold</string>
///             <key>fontSize</key>
///             <integer>17</integer>
///         </dict>
///     </dict>
///
/// You do not need to include an entry for every text style
/// but if you try to use a text style that is not included
/// in the dictionary it will fallback to the system preferred
/// font.
/*
 Type Properties
 static let body: UIFont.TextStyle
 The font used for body text.
 static let callout: UIFont.TextStyle
 The font used for callouts.
 static let caption1: UIFont.TextStyle
 The font used for standard captions.
 static let caption2: UIFont.TextStyle
 The font used for alternate captions.
 static let footnote: UIFont.TextStyle
 The font used in footnotes.
 static let headline: UIFont.TextStyle
 The font used for headings.
 static let subheadline: UIFont.TextStyle
 The font used for subheadings.
 static let largeTitle: UIFont.TextStyle
 The font style for large titles.
 static let title1: UIFont.TextStyle
 The font used for first level hierarchical headings.
 static let title2: UIFont.TextStyle
 The font used for second level hierarchical headings.
 static let title3: UIFont.TextStyle
 The font used for third level hierarchical headings.
 Initializers

 */
/*
 //Print fonts Names
 for family in UIFont.familyNames {

 let sName: String = family as String
 print("family: \(sName)")

 for name in UIFont.fontNames(forFamilyName: sName) {
 print("\t name: \(name as String)")
 }
 }
 */
/*

 family: SF Pro Text
 name: SFProText-Medium
 name: SFProText-Bold
 name: SFProText-Light
 name: SFProText-Regular
 name: SFProText-Thin
 name: SFProText-Semibold

 */

//TODO Better Naming
/*
 font Size to be
 10  => 1
 12  => 2
 14  => 3
 16  => 4
 18  => 5
 20  => 6
 24  => 7
 32  => 8


 for font Style / Weight
 Bold
 Light
 Medium
 Regular
 semibold
 thin

 Compination:
 bold1
 bold2
 bold3
 regular3
 regular4

 */
public enum AppFontStyle: String {

    case body1normal = "AppFontStyleB1Normal"
     case title1Bold = "AppFontStyleT1Bold"//Font Family: SF Pro Text; Font Style: Normal; Font Size: 16 pt
     case title2Bold = "AppFontStyleT2Bold"

    /// this properity represent the most nearest size in the System text Style  to the App Style
    var systemStyle: UIFont.TextStyle {
        switch self {
            case .body1normal, .title1Bold, .title2Bold:
            return UIFont.TextStyle.body
        }
    }
}

struct AppFonts {

    static var current: Fonts = .mainEnglish

    enum Fonts: String {
        case mainEnglish = "EnglishStyle"

        var scaledFont: ScaledFont {
            switch self {
            case .mainEnglish:
                return AppFonts.mainEnglishScaledFont
            }
        }
    }

    static private var mainEnglishScaledFont: ScaledFont = {
        return ScaledFont(fontName: Fonts.mainEnglish.rawValue)
    }()
}

public final class ScaledFont {

    private struct FontDescription: Decodable {
        let fontSize: CGFloat
        let fontName: String
    }

    private typealias StyleDictionary = [UIFont.TextStyle.RawValue: FontDescription]
    private var styleDictionary: StyleDictionary?

    /// Create a `ScaledFont`
    ///
    /// - Parameter fontName: Name of a plist file (without the extension)
    ///   in the main bundle that contains the style dictionary used to
    ///   scale fonts for each text style.

    public init(fontName: String) {
        if let url = Bundle.main.url(forResource: fontName, withExtension: "plist"),
            let data = try? Data(contentsOf: url) {
            let decoder = PropertyListDecoder()
            styleDictionary = try? decoder.decode(StyleDictionary.self, from: data)
        }
    }

    /// Get the scaled font for the given text style using the
    /// style dictionary supplied at initialization.
    ///
    /// - Parameter textStyle: The `UIFontTextStyle` for the
    ///   font.
    /// - Returns: A `UIFont` of the custom font that has been
    ///   scaled for the users currently selected preferred
    ///   text size.
    ///
    /// - Note: If the style dictionary does not have
    ///   a font for this text style the default preferred
    ///   font is returned.

    public func font(forTextStyle textStyle: AppFontStyle) -> UIFont {
        guard let fontDescription = styleDictionary?[textStyle.rawValue],
            let font = UIFont(name: fontDescription.fontName, size: fontDescription.fontSize) else {
                return UIFont.preferredFont(forTextStyle: textStyle.systemStyle)
        }
        if #available(iOS 11.0, *) {
            let fontMetrics = UIFontMetrics(forTextStyle: textStyle.systemStyle)
            return fontMetrics.scaledFont(for: font)
        } else {
            return font
        }

    }
}

extension AppFonts {
    /// Wrapper function for the currect Scaled font
    static func font(forTextStyle style: AppFontStyle) -> UIFont {
        return AppFonts.current.scaledFont.font(forTextStyle: style)
    }
}

extension UILabel {
    func setFont(style: AppFontStyle) {
        let styleFont = AppFonts.font(forTextStyle: style)
        self.font = styleFont
    }

    /// set the text as attributedText to change lineHeight in Pt than the default lineheight in the Font
    /// - Parameters:
    ///   - text: text to set to lable , all text will be applyed as attributed text
    ///   - style: App Text Style
    ///   - lineHeight: line Height in pt
    func setText(text: String, style: AppFontStyle, lineHeight: CGFloat) {
        let styleFont = AppFonts.font(forTextStyle: style)
        self.font = styleFont
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = lineHeight
        paragraphStyle.maximumLineHeight = lineHeight
        paragraphStyle.alignment = self.textAlignment
        attributedText = NSMutableAttributedString(
            string: text,
            attributes: [NSAttributedString.Key.font: styleFont,
                         NSAttributedString.Key.paragraphStyle: paragraphStyle])

        // NSAttributedString.Key.kern: -0.5 we don't want to change kern-pair characters
    }

    /// set the text as attributedText to change line Height in percentage than the default lineheight in the Font
    /// - Parameters:
    ///   - text: text to set to lable , all text will be applyed as attributed text
    ///   - style: style description
    ///   - lineHeightMultiple: float number for percentage  as 1 = 100%

    func setText(text: String, style: AppFontStyle, lineHeightMultiple: CGFloat) {
        let styleFont = AppFonts.font(forTextStyle: style)
        self.font = styleFont
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = lineHeightMultiple
        paragraphStyle.alignment = self.textAlignment
        attributedText = NSMutableAttributedString(
            string: text,
            attributes: [NSAttributedString.Key.kern: -0.5,
                         NSAttributedString.Key.font: styleFont,
                         NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
}

extension UIButton {
    func setFont(style: AppFontStyle) {
        let styleFont = AppFonts.font(forTextStyle: style)
        self.titleLabel?.font = styleFont
    }
}
