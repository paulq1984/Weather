//
//  UIApplication+Extension.swift
//  Weather
//
//  Created by Paul Quinnell on 2022-11-07.
//

import UIKit

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
