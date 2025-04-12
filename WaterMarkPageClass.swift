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
        context.translateBy(x: 0.0, y: pageBounds.size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        context.rotate(by: CGFloat.pi / 4.0)


        let string: NSMutableAttributedString=WaterMarkPageClass.WaterString
        string.setAttributes([NSAttributedString.Key.font:UIFont.systemFont(ofSize: 64)], range: NSRange(location: 0, length: string.length))
        let attributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.4980392157, green: 0.4980392157, blue: 0.4980392157, alpha: 0.5),
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 64)
        ]


        string.draw(at: CGPoint(x: 250, y: 40))


        context.restoreGState()
        UIGraphicsPopContext()


    }
}
