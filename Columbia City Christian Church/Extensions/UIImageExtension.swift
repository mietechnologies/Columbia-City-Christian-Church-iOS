//
//  UIImageExtension.swift
//  Columbia City Christian Church
//
//  Created by Brett Chapin on 6/21/24.
//

import UIKit

extension UIImage {
    func cropTo(_ rect: CGRect) -> UIImage? {
        guard let cgImage = self.cgImage else { return nil }
        guard let croppedCGImage = cgImage.cropping(to: rect) else { return nil }
        return UIImage(cgImage: croppedCGImage)
    }
}
