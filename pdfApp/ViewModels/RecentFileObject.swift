//
//  RecentFileObject.swift
//  pdfApp
//
//  Created by Ashish on 12/04/25.
//

import Foundation
import PDFKit
class RecentFileObject:ObservableObject{
    @Published var pdfArr:[PDFModel]=[]
    @Published var dates:[String]=[]
    let datef_=DateFormatter()
      func loadlocalFiles()
    {
        pdfArr.removeAll()
        DispatchQueue.global(qos:.userInteractive).async
        {
            let fileManager = FileManager.default
            let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
            let files = try! fileManager.contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: [.creationDateKey])
            for item in files{
                if  let pdfDoc=PDFDocument(url: item){
                    let model=PDFModel(pdfDoc:pdfDoc , pdfThumbnail: MergeViewModel.makePDFThumbnail(pdfDoc: pdfDoc), name: item.lastPathComponent, pages: pdfDoc.pageCount)
                    print(model.name)
                    
              
                    let dateCreated = try! item.resourceValues(forKeys: [.creationDateKey])
                    let newDate = dateCreated.creationDate?.formatted(date: .long, time: .omitted)
                    DispatchQueue.main.async{
                        self.pdfArr.append(model)
                        self.dates.append(newDate!)
                    }
                }
            }
        }
    }
    func addFile(pdfModel:PDFModel)
    {
        pdfArr.append(pdfModel)
    }
    
    func RemoveFile(pdfModel:PDFModel)
    {
        pdfArr.removeAll(where: {$0==pdfModel})
    }
    init(){
        datef_.dateStyle = .long
        datef_.timeStyle = .none
    }
}

