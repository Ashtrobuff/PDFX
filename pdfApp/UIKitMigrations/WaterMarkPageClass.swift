//
//  WaterMarkPageClass.swift
//  pdfApp
//
//  Created by Ashish on 07/04/25.
//

import Foundation
import PDFKit

class WaterMarkPageClass:PDFPage
{
   static var WaterString:NSMutableAttributedString=NSMutableAttributedString(string: "hellow")
    override func draw(with box: PDFDisplayBox, to context: CGContext) {
    

        // Draw original content
        super.draw(with: box, to: context)


        // Draw rotated overlay string
        UIGraphicsPushContext(context)
        context.saveGState()


        let pageBounds = self.bounds(for: box)
        context.translateBy(x:2.5, y: pageBounds.size.height)
        context.scaleBy(x: 1.0, y: -1.03)
        context.rotate(by: CGFloat.pi / 4.0)


        let string: NSMutableAttributedString=WaterMarkPageClass.WaterString
        string.addAttributes([ NSMutableAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 64)],range:.init(location: 0, length: string.length))

        string.draw(at: CGPoint(x: 250, y: 40))


        context.restoreGState()
        UIGraphicsPopContext()


    }
}
