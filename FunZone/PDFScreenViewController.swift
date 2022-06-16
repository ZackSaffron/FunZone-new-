//
//  PDFScreenViewController.swift
//  PDFReaderDemo
//
//  Created by admin on 6/1/22.
//

import UIKit
import PDFKit

class PDFScreenViewController: UIViewController {
    
    var pdfName: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pdfView = PDFView(frame: view.bounds)
        pdfView.addSubview(pdfView)
        pdfView.autoScales = true
        let filePath = Bundle.main.url(forResource: "HistoryOfApple", withExtension: "pdf")
        let filePath1 = Bundle.main.url(forResource: "ios", withExtension: "pdf")
        pdfView.document = PDFDocument(url: filePath!)

    }
    

    
}

