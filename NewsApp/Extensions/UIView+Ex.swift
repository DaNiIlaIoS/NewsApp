//
//  UIView+Ex.swift
//  NewsApp
//
//  Created by Даниил Сивожелезов on 06.06.2024.
//

import UIKit

extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach { view in
            addSubview(view)
        }
    }
}
