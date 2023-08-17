//
//  YapilacaklarKayitViewModel.swift
//  YapilacaklarUygulamasi
//
//  Created by Berna Şener on 14.08.2023.
//

import Foundation

class YapilacaklarKayitViewModel{
    var yrepo=YapilacaklarDaoRepository()
    
    func kaydet(yapilacak_ad:String){
        yrepo.kaydet(yapilacak_ad: yapilacak_ad)
    }
}
