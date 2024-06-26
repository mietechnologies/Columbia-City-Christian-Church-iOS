//
//  UIImageExtension.swift
//  Columbia City Christian Church
//
//  Created by Brett Chapin on 6/21/24.
//

import UIKit

extension UIImage {
    /**
     A method to crop the given image, `self`, to a specific value within its frame.
     
     - Parameter rect: A `CGRect` that represents the location and size of the crop relative to the current image.
     - Returns: The cropped `UIImage` from the starting image.
     */
    func cropTo(_ rect: CGRect) -> UIImage? {
        guard let cgImage = self.cgImage else { return nil }
        guard let croppedCGImage = cgImage.cropping(to: rect) else { return nil }
        return UIImage(cgImage: croppedCGImage)
    }
}
