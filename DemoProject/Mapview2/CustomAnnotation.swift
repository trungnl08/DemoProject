//
//  CustomAnnotation.swift
//  DemoProject
//
//  Created by Frog Pepe on 29/06/2022.
//

import UIKit
import MapKit


class CustomAnnotation : MKPointAnnotation {
    var pinCustomImage: UIImage!
   
   
    func resizeImage(image: UIImage!, targetSize: CGSize) -> UIImage! {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(origin: .zero, size: newSize)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
}

class CustomAnnotationView: MKAnnotationView {
    override init(annotation: MKAnnotation?, reuseIdentifier: String?){
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        canShowCallout = true    
        update(for: annotation)
    }
    
    override var annotation: MKAnnotation? { didSet { update(for:annotation)}}

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func update(for annotation: MKAnnotation?){
        image = (annotation as? CustomAnnotation)?.pinCustomImage
    }
}
