//
//  ViewController.swift
//  YapilacaklarUygulamasi
//
//  Created by Berna Şener on 3.08.2023.
//

import UIKit

class Anasayfa: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var yapilacakTableView: UITableView!
    
    var yapilacaklarListesi = [Yapilacaklar]()
    var viewModel=AnasayfaViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        yapilacakTableView.delegate = self
        yapilacakTableView.dataSource = self
        
        _=viewModel.yapilacaklarListesi.subscribe(onNext: { liste in
            self.yapilacaklarListesi=liste
            self.yapilacakTableView.reloadData()
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.yapilacaklariYukle()
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetay" {
            if let yapilacak = sender as? Yapilacaklar {
                let gidilecekVC = segue.destination as! YapilacaklarDetay
                gidilecekVC.yapilacak = yapilacak
            }
        }
    }
    
   
}

extension Anasayfa : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.ara(aramaKelimesi:  searchText )
    }
}

extension Anasayfa : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return yapilacaklarListesi.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let yapilacak = yapilacaklarListesi[indexPath.row]
        
        let hucre = tableView.dequeueReusableCell(withIdentifier: "yapilacaklarHucre") as! YapilacakHucre
        
        hucre.labelYapilacakAd.text = yapilacak.yapilacak_ad
        
        return hucre
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let yapilacak = yapilacaklarListesi[indexPath.row]
        
        performSegue(withIdentifier: "toDetay", sender: yapilacak)
        tableView.deselectRow(at: indexPath, animated: true)
         
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let silAction = UIContextualAction(style: .destructive , title: "Sil"){contextualAction,view,bool in
            let yapilacak = self.yapilacaklarListesi[indexPath.row]
            
            let alert = UIAlertController(title: "Silme İşlemi", message: "\(yapilacak.yapilacak_ad!) Silinsin mi? ", preferredStyle: .alert)
            
            let iptalAction = UIAlertAction(title: "İptal", style: .cancel)
            alert.addAction(iptalAction)
            
            let evetAction = UIAlertAction(title: "Evet", style: .destructive){ action in
                self.viewModel.sil(yapilacak_id: yapilacak.yapilacak_id!)
            }
            alert.addAction(evetAction)
            
            self.present(alert, animated: true)
            
            
        }
        
        return UISwipeActionsConfiguration(actions: [silAction])
    }
}

