//
//  YapilacaklarDaoRepository.swift
//  YapilacaklarUygulamasi
//
//  Created by Berna Şener on 14.08.2023.
//

import Foundation
import RxSwift


class YapilacaklarDaoRepository{
    var yapilacaklarListesi = BehaviorSubject<[Yapilacaklar]>(value: [Yapilacaklar]())
    
    let db:FMDatabase?
    
    init(){
        let dosyaYolu = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let veritabaniURL = URL(fileURLWithPath: dosyaYolu).appendingPathComponent("Yapilacaklar.sqlite")
        db = FMDatabase(path: veritabaniURL.path)
        
    }
    
    func kaydet(yapilacak_ad:String){
        db?.open()
        
        do{
            try db!.executeUpdate("INSERT  INTO yapilacaklar (yapilacak_ad) VALUES (?) ", values:[yapilacak_ad])
        }
        catch{
            print(error.localizedDescription)
        }
 
        db?.close()
    }
    
    func guncelle(yapilacak_id:Int,yapilacak_ad:String){
        db?.open()
        
        do{
            try db!.executeUpdate("UPDATE yapilacaklar SET yapilacak_ad=? WHERE  yapilacak_id=?", values:[yapilacak_ad,yapilacak_id])
        }
        catch{
            print(error.localizedDescription)
        }
 
        db?.close()
    }
    
    func sil(yapilacak_id:Int){
        db?.open()
        
        do{
            try db!.executeUpdate("DELETE FROM yapilacaklar WHERE yapilacak_id=?", values:[yapilacak_id])
        }
        catch{
            print(error.localizedDescription)
        }
 
        db?.close()
    }
    
    func ara(aramaKelimesi:String){
        
        db?.open()
        
        var liste =  [Yapilacaklar]()
        
        do{
            let result = try db!.executeQuery("SELECT * FROM yapilacaklar WHERE yapilacak_ad like '%\(aramaKelimesi)%'", values: nil)
            while result.next(){
                let yapilacak_id = Int(result.string(forColumn: "yapilacak_id"))!
                let yapilacak_ad = result.string(forColumn: "yapilacak_ad")!
                
                let yapilacak = Yapilacaklar(yapilacak_id: yapilacak_id, yapilacak_ad: yapilacak_ad)
                liste.append(yapilacak)
            }
            
            yapilacaklarListesi.onNext(liste)//Tetikleme
        }
        catch{
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    func yapilacaklariYukle(){
       
        db?.open()
        
        var liste =  [Yapilacaklar]()
        
        do{
            let result = try db!.executeQuery("SELECT * FROM yapilacaklar", values: nil)
            while result.next(){
                let yapilacak_id = Int(result.string(forColumn: "yapilacak_id"))!
                let yapilacak_ad = result.string(forColumn: "yapilacak_ad")!
                
                let yapilacak = Yapilacaklar(yapilacak_id: yapilacak_id, yapilacak_ad: yapilacak_ad)
                liste.append(yapilacak)
            }
            
            yapilacaklarListesi.onNext(liste)//Tetikleme
        }
        catch{
            print(error.localizedDescription)
        }
        
        db?.close()
        
    }
}
