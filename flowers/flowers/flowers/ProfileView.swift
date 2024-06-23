//
//  ProfileView.swift
//  flowers
//
//  Created by Irina on 29.05.2024.
//

import Foundation
import UIKit


var userCity = String()
class ProfileView : UIViewController{
    @IBOutlet weak var checkProgress: UIButton!
    @IBAction func checkIt(_ sender: Any) {
        collectedPlants = myFlowers.count
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let secondVC = storyboard.instantiateViewController(identifier: "MyProgressView")
                    
                    secondVC.modalPresentationStyle = .fullScreen
                    secondVC.modalTransitionStyle = .crossDissolve
                    
                    present(secondVC, animated: true, completion: nil)
        
    }
    
    private var weatherVM = WeatherViewModel()
    @objc  func loadInfo(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let secondVC = storyboard.instantiateViewController(identifier: "PlantInfoView") as FlowerInfoView
       
                    
                    secondVC.modalPresentationStyle = .fullScreen
                    secondVC.modalTransitionStyle = .crossDissolve
                    
                    present(secondVC, animated: true, completion: nil)
    }
    private var galleryCollectionView = MyFlowersCollectionView()

    @IBOutlet weak var titleLabel1: UILabel!
    @IBOutlet weak var weather: UILabel!
    @IBOutlet weak var checkButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        pageSwitcher.selectedSegmentIndex = 0
       
        let path_plants = Bundle.main.path(forResource: "usersFlowers", ofType: "plist")

        let dictionary = NSMutableDictionary(contentsOfFile: path_plants!)
        let arr = dictionary?.object(forKey: "plants_\(current_user)") as? [String]
        var i = 0
        while(i < arr?.count ?? 0){
            myFlowers.insert(arr![i])
            i += 1
        }
        
        let path_city = Bundle.main.path(forResource: "userCity", ofType: "plist")

                    let plist2 = NSMutableDictionary(contentsOfFile: path_city!)
        userCity = plist2?.object(forKey: current_user) as! String
        
        self.weatherVM.fetchWeather(city: userCity)
        sleep(1)
        print(userCity)
        weather.text  = "T: " + String(Int(weatherVM.temperature)) + "ºC"
        
        view.addSubview(galleryCollectionView)
        galleryCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        galleryCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        galleryCollectionView.topAnchor.constraint(equalTo: weather.bottomAnchor, constant: 10).isActive = true
        galleryCollectionView.heightAnchor.constraint(equalToConstant: 500).isActive = true
        galleryCollectionView.set(cells: FlowerModel.unfetchFlowers())
        NotificationCenter.default.addObserver(self, selector: #selector(loadInfo), name: NSNotification.Name("loadInfo"), object: nil)
        
        pageSwitcher.setTitle(NSLocalizedString("my plants", comment: ""), forSegmentAt: 0)
        pageSwitcher.setTitle(NSLocalizedString("add plant", comment: ""), forSegmentAt: 1)
        
        titleLabel1.text = NSLocalizedString("My plants", comment: "")
        
        checkButton.setTitle(NSLocalizedString("Check progress!", comment: ""), for: .normal)
    }
    
    @IBOutlet weak var pageSwitcher: UISegmentedControl!
    @IBAction func switchPage(_ sender: Any) {
        if pageSwitcher.selectedSegmentIndex == 1 {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let secondVC = storyboard.instantiateViewController(identifier: "PlantsCollectionView")
                        
                        secondVC.modalPresentationStyle = .fullScreen
                        secondVC.modalTransitionStyle = .crossDissolve
                        
                        present(secondVC, animated: true, completion: nil)
        }
    }
}
