//
//  Extensions.swift
//  ChatWithAI
//
//  Created by Egehan Karaköse on 22.12.2022.
//

import Foundation
import SwiftUI

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

extension String {
    public func removingLeadingSpaces() -> String {
        if self == " " {
          return ""
        }
        guard let index = firstIndex(where: { !CharacterSet(charactersIn: String($0)).isSubset(of: .whitespaces) }) else {
          return self
        }
        return String(self[index...])
      }
    
    public func removingLeadingNewLines() -> String {
        if self == " " {
          return ""
        }
        guard let index = firstIndex(where: { !CharacterSet(charactersIn: String($0)).isSubset(of: .whitespacesAndNewlines) }) else {
          return self
        }
        return String(self[index...])
      }
    
    public func slice(from: String, toward: String) -> String? {
        let rangeFrom = range(of: from)?.upperBound ?? self.startIndex
        guard let rangeTo = self[rangeFrom...].range(of: toward)?.lowerBound else {
          return String(self[rangeFrom..<self.endIndex])
        }
        return String(self[rangeFrom..<rangeTo])
      }
}
