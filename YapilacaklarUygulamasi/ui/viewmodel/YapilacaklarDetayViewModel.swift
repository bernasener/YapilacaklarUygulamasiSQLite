//
//  YapilacaklarDetayViewModel.swift
//  YapilacaklarUygulamasi
//
//  Created by Berna Şener on 14.08.2023.
//

import Foundation

class YapilacaklarDetayViewModel{
    var yrepo=YapilacaklarDaoRepository()
    
    func guncelle(yapilacak_id:Int,yapilacak_ad:String){
        yrepo.guncelle(yapilacak_id: yapilacak_id, yapilacak_ad: yapilacak_ad)
    }
}
