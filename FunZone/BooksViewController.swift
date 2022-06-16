//
//  BooksViewController.swift
//  FunZone
//
//  Created by admin on 6/1/22.
//

import UIKit
import PDFKit

class BooksViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var bookData = ["HistoryOfApple", "ios"]
    var pdfView: PDFView? = nil
    var pdfName: String?
    
//    private func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewCell, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let screenSize: CGRect = UIScreen.main.bounds
//        let screenDimen = screenSize.width / 5 * 2
//        return CGSize(width: screenDimen, height: screenDimen)
//    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! BooksCollectionViewCell
        cell.bookLabel.text = bookData[indexPath.row]
        return cell
            
    }
    
    @IBOutlet weak var customView: UIView!
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        generatePDFView(Index: indexPath.row)
        
//        switch indexPath.row {
//
//        case 0:
//            let storyObject = UIStoryboard(name: "Main", bundle: nil)
//            let pdfScreenVC = storyObject.instantiateViewController(withIdentifier: "pdfScreen") as! PDFScreenViewController
//            pdfScreenVC.pdfName = bookData[indexPath.row]
//            self.present(pdfScreenVC, animated: true, completion: nil)
//
//        case 1:
//            let storyObject = UIStoryboard(name: "Main", bundle: nil)
//            let pdfScreenVC = storyObject.instantiateViewController(withIdentifier: "pdfScreen") as! PDFScreenViewController
//            pdfScreenVC.pdfName = bookData[indexPath.row]
//            self.present(pdfScreenVC, animated: true, completion: nil)
//
//        default:
//            print("")
//        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func generatePDFView(Index: Int) {
        let pdfView = PDFView(frame: customView.bounds)
        customView.addSubview(pdfView)
        pdfView.autoScales = true
        let filePath = Bundle.main.url(forResource: bookData[Index], withExtension: "pdf")
        pdfView.document = PDFDocument(url: filePath!)

    }
    
}
