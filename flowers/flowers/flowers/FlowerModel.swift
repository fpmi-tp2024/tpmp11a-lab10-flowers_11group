//
//  FlowerModel.swift
//  flowers
//
//  Created by Irina on 29.05.2024.
//

import UIKit

 var myFlowers = Set <String>()


struct FlowerModel{
    var mainImage : UIImage
    var flowerName: String
    static func fetchPlants() -> [FlowerModel]{
        let path = Bundle.main.path(forResource: "flowersData", ofType: "plist")
        let dictionary = NSDictionary(contentsOfFile: path!)
        let data = dictionary?.object(forKey: "plants") as? [NSDictionary]
        let n : Int = data?.count ?? 0
        var arr = [FlowerModel]()
        var i : Int = 0
        while(i < n){
            let imgName = data?[i].object(forKey: "image") as! String
            let name = data?[i].object(forKey: "name") as! String
            if (myFlowers.contains(name)){
                i += 1
                
            }
            else{
                guard let img = UIImage(named: imgName as! String) else { return [] }
                let p1 = FlowerModel(mainImage: img, flowerName: name as! String)
                arr.append(p1)
                i += 1
            }

        }
           return arr.sorted(by: {$0.flowerName < $1.flowerName})
       
       
    }
    static func unfetchFlowers() -> [FlowerModel]{
        let path = Bundle.main.path(forResource: "flowersData", ofType: "plist")
        let dictionary = NSDictionary(contentsOfFile: path!)
        let data = dictionary?.object(forKey: "plants") as? [NSDictionary]
        let n : Int = data?.count ?? 0
        var arr = [FlowerModel]()
        var i : Int = 0
        while(i < n){
            let imgName = data?[i].object(forKey: "image") as! String
            let name = data?[i].object(forKey: "name") as! String
            if (myFlowers.contains(name)){
                guard let img = UIImage(named: imgName as! String) else { return [] }
                let p1 = FlowerModel(mainImage: img, flowerName: name as! String)
                arr.append(p1)
            }
            i += 1

        }
       
        return arr.sorted(by: {$0.flowerName < $1.flowerName})
       
       
    }
}


