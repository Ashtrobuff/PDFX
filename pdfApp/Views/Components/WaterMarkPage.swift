//
//  WaterMarkPage.swift
//  pdfApp
//
//  Created by Ashish on 06/04/25.
//

import SwiftUI

struct WaterMarkPage: View {
    @EnvironmentObject var waterWm:WaterMarkViewModel
    @State var textString:String="fuck me"
    @State var text:NSMutableAttributedString=NSMutableAttributedString(string: "WaterMark")
    @Binding var navPath:NavigationPath
    @State var resVersion:Int=0
    @State var color:Color=Color.red
    @State var weight:UIFont.Weight = .bold
    @State var rotation:Double=0
    var body: some View {
        Form{
            ZStack{
                HStack{
                    Spacer()
                    Text(text).rotationEffect(.degrees(rotation)).id(resVersion).font(.system(size: 30))
                    Spacer()
                } .onChange(of: color) { _ in applyAttributes() }
                    .onChange(of: rotation) { _ in applyAttributes() }
                    .onChange(of: textString) { newValue in
                                       text = NSMutableAttributedString(string: newValue)
                                       applyAttributes()
                                   }
            }.frame(minHeight:100)
                .onAppear {
                    applyAttributes()
                }
            Section("Watermark Text"){
            ZStack{
                TextField(text: $textString, prompt: Text("Required")) {
                        
                    }
            }
        }
            Section("Rotation"){
                Slider(value: $rotation,in: -180...180)
            }
            ColorPicker("Set Watermark color", selection: $color)
            
            Picker("Font Weight", selection: $weight) {
                                Text("Bold")
                                .tag(UIFont.Weight.bold)
                                Text("Light")
                    .tag(UIFont.Weight.light)
                                Text("Ultralight")
                    .tag(UIFont.Weight.ultraLight)
                            }.onChange(of: weight) { _ in
                                applyAttributes()
                            }
                            .pickerStyle(.inline)
            
            
        }.onAppear{
            applyAttributes()
        }.onDisappear{
            self.text=NSMutableAttributedString(string:"")
        }
        Button
        {
            DispatchQueue.global(qos: .userInitiated).async{
                let pdfHasher=PDFWaterHashArr(pdfArr:waterWm.pdfArr)
            DispatchQueue.main.asyncAfter(deadline: .now()+4){
                //   navPath.append(NavigationDestinationsEnum.WaterMark)
                
                navPath.append(pdfHasher)
            }
        }
        }label:
        {
                Text("Proceed")
            
        }.buttonStyle(.borderedProminent)
            .controlSize(.extraLarge).foregroundColor(.white).padding().tint(.blue)
  
    }
    func applyAttributes()
    {
        let color=self.color
        let weight=self.weight
        
        self.text.setAttributes([.foregroundColor:UIColor(color),.font:self.weight],range: NSRange(location:0,length:text.length))
        
        self.resVersion+=1
        waterWm.WaterMarkString=text
    }
}



//#Preview {
//    WaterMarkPage()
//}

extension Text {
    init(_ astring: NSAttributedString) {
        self.init("")
        
        astring.enumerateAttributes(in: NSRange(location: 0, length: astring.length), options: []) { (attrs, range, _) in
            
            var t = Text(astring.attributedSubstring(from: range).string)

            if let color = attrs[NSAttributedString.Key.foregroundColor] as? UIColor {
                t  = t.foregroundColor(Color(color))
            }

            if let font = attrs[NSAttributedString.Key.font] as? UIFont {
                t  = t.font(.init(font))
            }

            if let kern = attrs[NSAttributedString.Key.kern] as? CGFloat {
                t  = t.kerning(kern)
            }
            
            
            if let striked = attrs[NSAttributedString.Key.strikethroughStyle] as? NSNumber, striked != 0 {
                if let strikeColor = (attrs[NSAttributedString.Key.strikethroughColor] as? UIColor) {
                    t = t.strikethrough(true, color: Color(strikeColor))
                } else {
                    t = t.strikethrough(true)
                }
            }
            
            if let baseline = attrs[NSAttributedString.Key.baselineOffset] as? NSNumber {
                t = t.baselineOffset(CGFloat(baseline.floatValue))
            }
            
            if let underline = attrs[NSAttributedString.Key.underlineStyle] as? NSNumber, underline != 0 {
                if let underlineColor = (attrs[NSAttributedString.Key.underlineColor] as? UIColor) {
                    t = t.underline(true, color: Color(underlineColor))
                } else {
                    t = t.underline(true)
                }
            }
            
            self = self + t
            
        }
    }
}
