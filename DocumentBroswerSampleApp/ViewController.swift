//
//  ViewController.swift
//  DocumentBroswerSampleApp
//
//  Created by Enrico Rosignoli on 1/29/20.
//  Copyright © 2020 AimTech. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UIDocumentBrowserViewControllerDelegate {

    var documentBrowserViewController : UIDocumentBrowserViewController?

    override func viewDidLoad() {
        super.viewDidLoad()

        documentBrowserViewController = UIDocumentBrowserViewController()
        documentBrowserViewController!.delegate = self
        documentBrowserViewController!.allowsDocumentCreation = false

        let when = DispatchTime.now() + 1
                  DispatchQueue.main.asyncAfter(deadline: when, execute: { [weak self] in
                     
                     guard let self = self else {
                         return
                     }
                    //self.doIt()

                  })
    }

    func doIt(){
        let documentBrowserViewController = UIDocumentBrowserViewController()
        documentBrowserViewController.delegate = self
        documentBrowserViewController.allowsDocumentCreation = false

        self.present(documentBrowserViewController, animated: true) {
            
            
        }
        //documentBrowserViewController.presentDocument(at: revealedDocumentURL!)

    }

    
    func documentBrowser(_ controller: UIDocumentBrowserViewController, didPickDocumentsAt documentURLs: [URL]) {
        
        let s = documentURLs[0]
        print(s)
        
    }
}

