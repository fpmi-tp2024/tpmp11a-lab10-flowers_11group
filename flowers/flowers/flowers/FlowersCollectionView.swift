//
//  PlantsCollectionView.swift
//  flowers
//
//  Created by Irina on 29.05.2024.
//

import UIKit

var downLoads = 0
class FlowersCollectionView: UIViewController, UITextFieldDelegate {
    
    var allFlowers = [FlowerModel]()
    var filteredFlowers = [FlowerModel]()
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var searchBarField: UITextField!
    @IBOutlet weak var pageSwitcher: UISegmentedControl!
    
    private var galleryCollectionView = GalleryCollectionView()
    
    @objc func loadNew() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let secondVC = storyboard.instantiateViewController(identifier: "ProfileView")
        
        secondVC.modalPresentationStyle = .fullScreen
        secondVC.modalTransitionStyle = .crossDissolve
        
        present(secondVC, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(loadNew), name: NSNotification.Name("loadNew"), object: nil)
        
        searchBarField.delegate = self
        
        let imageView = UIImageView()
        let magnifyingGlassImage = UIImage(systemName: "magnifyingglass", withConfiguration: UIImage.SymbolConfiguration(weight: .regular))?.withTintColor(.systemGray, renderingMode: .alwaysOriginal)
        imageView.image = magnifyingGlassImage
        imageView.frame = CGRect(x: 50, y: 5, width: 45, height: 20)
        imageView.contentMode = .scaleAspectFit
        searchBarField.leftViewMode = .always
        searchBarField.leftView = imageView
        
        view.addSubview(galleryCollectionView)
        galleryCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        galleryCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        galleryCollectionView.topAnchor.constraint(equalTo: searchBarField.bottomAnchor, constant: 10).isActive = true
        galleryCollectionView.heightAnchor.constraint(equalToConstant: 600).isActive = true
        
        allFlowers = FlowerModel.fetchPlants()
        filteredFlowers = allFlowers
        
        galleryCollectionView.set(cells: filteredFlowers)
        
        pageSwitcher.setTitle(NSLocalizedString("my plants", comment: ""), forSegmentAt: 0)
        pageSwitcher.setTitle(NSLocalizedString("add plant", comment: ""), forSegmentAt: 1)
        titleLabel.text = NSLocalizedString("MBS", comment: "")
        searchBarField.placeholder = NSLocalizedString("search plants", comment: "")
    }
    
    @IBAction func searcBar(_ sender: Any) {
        if let searchText = searchBarField.text, !searchText.isEmpty {
            filteredFlowers = allFlowers.filter { $0.flowerName.localizedCaseInsensitiveContains(searchText) }
        } else {
            filteredFlowers = allFlowers
        }
        galleryCollectionView.set(cells: filteredFlowers)
    }
    
    @IBAction func switchPage(_ sender: Any) {
        if pageSwitcher.selectedSegmentIndex == 0 {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let secondVC = storyboard.instantiateViewController(identifier: "ProfileView")
            
            secondVC.modalPresentationStyle = .fullScreen
            secondVC.modalTransitionStyle = .crossDissolve
            
            present(secondVC, animated: true, completion: nil)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let searchText = textField.text, let textRange = Range(range, in: searchText) {
            let updatedText = searchText.replacingCharacters(in: textRange, with: string)
            filteredFlowers = allFlowers.filter { $0.flowerName.localizedCaseInsensitiveContains(updatedText) }
            galleryCollectionView.set(cells: filteredFlowers)
        }
        return true
    }
}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


