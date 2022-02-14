//
//  DownSamplingExtension.swift
//  Appetites
//
//  Created by chavin Panicharoen on 10/2/2565 BE.
//

import Foundation
import UIKit

public extension UIImage {
    func downsampled(by reductionAmount: Float) -> UIImage? {

        let image = UIKit.CIImage(image: self)
        guard let lanczosFilter = CIFilter(name: "CILanczosScaleTransform") else { return nil }
        lanczosFilter.setValue(image, forKey: kCIInputImageKey)
        lanczosFilter.setValue(NSNumber.init(value: reductionAmount), forKey: kCIInputScaleKey)

        guard let outputImage = lanczosFilter.outputImage else { return nil }
        let context = CIContext(options: [CIContextOption.useSoftwareRenderer: false])
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return nil}
        let scaledImage = UIImage(cgImage: cgImage)

        return scaledImage
    }
}
