//
//  CustomAnnotation.swift
//  DemoProject
//
//  Created by Frog Pepe on 29/06/2022.
//

import UIKit
import MapKit


class ResizeImage  {
    var pinCustomImage: UIImage!
   
   
    
    
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
