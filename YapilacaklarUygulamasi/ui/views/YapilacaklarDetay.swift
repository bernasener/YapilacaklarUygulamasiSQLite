//
//  YapilacaklarDetay.swift
//  YapilacaklarUygulamasi
//
//  Created by Berna Şener on 3.08.2023.
//

import UIKit

class YapilacaklarDetay: UIViewController {
    
    @IBOutlet weak var tfYapilacakAd: UITextField!
    
    var yapilacak:Yapilacaklar?
    var viewModel=YapilacaklarDetayViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let y=yapilacak{
            tfYapilacakAd.text = y.yapilacak_ad
        }

    }
     
    @IBAction func buttonGuncelle(_ sender: Any) {
        if let ya=tfYapilacakAd.text, let y=yapilacak{
            viewModel.guncelle(yapilacak_id: y.yapilacak_id!, yapilacak_ad: ya)
        }
    }
}
