//
//  UIImageView+Ext.swift
//  CoreDataProject
//
//  Created by Vadim Kim on 19.08.2022.
//

import UIKit

extension UIImageView {
    func makeRounded() {
        self.layer.cornerRadius = self.frame.width / 2
        self.layer.masksToBounds = true
    }
}
