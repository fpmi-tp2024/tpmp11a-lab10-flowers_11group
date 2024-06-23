//
//  FlowerInfoView.swift
//  flowers
//
//  Created by Irina on 29.05.2024.
//

import UIKit
var plantName = String()

class FlowerInfoView: UIViewController {

    @IBOutlet weak var plantNameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var waterLabel: UILabel!
    @IBOutlet weak var careGuide: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var water: UILabel!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var size: UILabel!
    
    @IBOutlet weak var locationReq: UILabel!
    @IBOutlet weak var sizeReq: UILabel!
    @IBOutlet weak var humidityReq: UILabel!
    @IBOutlet weak var waterReq: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLabels()
        loadData()
        setupTapGestureRecognizers()
    }

    @IBAction func swipe(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let secondVC = storyboard.instantiateViewController(identifier: "ProfileView")
        secondVC.modalPresentationStyle = .fullScreen
        secondVC.modalTransitionStyle = .crossDissolve
        present(secondVC, animated: true, completion: nil)
    }
    
    func setupLabels() {
        water.layer.masksToBounds = true
        water.text = ""
        water.layer.cornerRadius = 10
        
        humidity.layer.masksToBounds = true
        humidity.text = ""
        humidity.layer.cornerRadius = 10
        
        location.layer.masksToBounds = true
        location.text = ""
        location.layer.cornerRadius = 10
        
        size.layer.masksToBounds = true
        size.text = ""
        size.layer.cornerRadius = 10
        
        careGuide.text = NSLocalizedString("Care guide", comment: "")
        waterLabel.text = NSLocalizedString("Water", comment: "")
        humidityLabel.text = NSLocalizedString("Humidity", comment: "")
        sizeLabel.text = NSLocalizedString("Size", comment: "")
        locationLabel.text = NSLocalizedString("Location", comment: "")
        
        // Скрыть текст в лейблах до нажатия
        waterReq.isHidden = true
        humidityReq.isHidden = true
        sizeReq.isHidden = true
        locationReq.isHidden = true
    }
    
    func loadData() {
        plantName = selectedPlant
        plantNameLabel.text = NSLocalizedString(plantName, comment: "")
        let path = Bundle.main.path(forResource: "flowersData", ofType: "plist")
        let dictionary = NSDictionary(contentsOfFile: path!)
        let data = dictionary?.object(forKey: "plantInfo") as? NSDictionary
        let dictPlant = data?.value(forKey: plantName) as? NSDictionary
        
        let imgName = dictPlant?.object(forKey: "image") as! String
        let dscr = dictPlant?.object(forKey: "description") as! String
        let waterText = dictPlant?.object(forKey: "water") as! String
        let humidityText = dictPlant?.object(forKey: "humidity") as! String
        let sizeText = dictPlant?.object(forKey: "size") as! String
        let locationText = dictPlant?.object(forKey: "location") as! String
        
        img.image = UIImage(named: imgName)
        descriptionLabel.text = NSLocalizedString(dscr, comment: "")
        waterReq.text = NSLocalizedString(waterText, comment: "")
        humidityReq.text = NSLocalizedString(humidityText, comment: "")
        sizeReq.text = NSLocalizedString(sizeText, comment: "")
        locationReq.text = NSLocalizedString(locationText, comment: "")
    }
    
    func setupTapGestureRecognizers() {
        let waterTap = UITapGestureRecognizer(target: self, action: #selector(showWaterInfo))
        water.addGestureRecognizer(waterTap)
        water.isUserInteractionEnabled = true
        
        let humidityTap = UITapGestureRecognizer(target: self, action: #selector(showHumidityInfo))
        humidity.addGestureRecognizer(humidityTap)
        humidity.isUserInteractionEnabled = true
        
        let locationTap = UITapGestureRecognizer(target: self, action: #selector(showLocationInfo))
        location.addGestureRecognizer(locationTap)
        location.isUserInteractionEnabled = true
        
        let sizeTap = UITapGestureRecognizer(target: self, action: #selector(showSizeInfo))
        size.addGestureRecognizer(sizeTap)
        size.isUserInteractionEnabled = true
    }
    
    @objc func showWaterInfo() {
        waterReq.isHidden = false
    }
    
    @objc func showHumidityInfo() {
        humidityReq.isHidden = false
    }
    
    @objc func showLocationInfo() {
        locationReq.isHidden = false
    }
    
    @objc func showSizeInfo() {
        sizeReq.isHidden = false
    }
}
