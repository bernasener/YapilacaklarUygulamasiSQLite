//
//  AnasayfaViewModel.swift
//  YapilacaklarUygulamasi
//
//  Created by Berna Şener on 14.08.2023.
//

import Foundation
import RxSwift

class AnasayfaViewModel{
    var yrepo = YapilacaklarDaoRepository()
    var yapilacaklarListesi = BehaviorSubject<[Yapilacaklar]>(value: [Yapilacaklar]())
    
    init(){
        veritabaniKopyala()
        yapilacaklarListesi=yrepo.yapilacaklarListesi
    }
    
    func sil(yapilacak_id:Int){
        yrepo.sil(yapilacak_id: yapilacak_id)
        yapilacaklariYukle()
    }
    
    func ara(aramaKelimesi:String){
        yrepo.ara(aramaKelimesi: aramaKelimesi)
    }
    
    func yapilacaklariYukle(){
        yrepo.yapilacaklariYukle()
    }
    
    func veritabaniKopyala(){
        let bundleYolu = Bundle.main.path(forResource: "Yapilacaklar", ofType: ".sqlite")
        
        let dosyaYolu = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        
        let veritabaniURL = URL(fileURLWithPath: dosyaYolu).appendingPathComponent("Yapilacaklar.sqlite")
        
        let fm = FileManager.default
        
        if fm.fileExists(atPath:  veritabaniURL.path()){
            print("Veri tabanı zaten var.")
        }
        else{
            do{
                try fm.copyItem(atPath: bundleYolu!, toPath: veritabaniURL.path)
            }
            catch{
                print(error.localizedDescription)
            }
            
        }
    }
}
