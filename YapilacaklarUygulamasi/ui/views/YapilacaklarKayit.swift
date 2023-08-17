//
//  YapilacaklarKayit.swift
//  YapilacaklarUygulamasi
//
//  Created by Berna Şener on 3.08.2023.
//

import UIKit

class YapilacaklarKayit: UIViewController {

    @IBOutlet weak var tfYapilacakAd: UITextField!
    
    var viewModel = YapilacaklarKayitViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func buttonKaydet(_ sender: Any) {
        if let ya=tfYapilacakAd.text{
            viewModel.kaydet(yapilacak_ad: ya )
        }
        
    }
    
}


