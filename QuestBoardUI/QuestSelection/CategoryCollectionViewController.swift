//
//  CategoryCollectionViewController.swift
//  QuestBoardUI
//
//  Created by Adam Teng Guan Tan on 7/4/21.
//

import UIKit

private let reuseIdentifier = "Cell"

class CategoryCollectionViewController: UICollectionViewController {

    
    var categoryArray: [Category] = []
    let sectionInserts = UIEdgeInsets(top: 20.0, left: 5.0, bottom: 20.0, right: 5.0)
    let itemsPerRow:CGFloat = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategory()
    
    }
    
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)

        
    }



    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return categoryArray.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CategoryCollectionViewCell
        
        cell.generateCell(categoryArray[indexPath.row])
        
        return cell
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "categoryToQuest", sender: categoryArray[indexPath.row])
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "categoryToQuest"
        {
            let vc = segue.destination as! ItemsTableViewController
            vc.category = sender as! Category
        }
    }
    
    //To download category
    func loadCategory()
    {
        //download from webservice if needed
        
        let walkDog = Category(_name: "Walk the Dog", _imageName: "walkdog.png")
        let dabao = Category(_name: "Let's Dabao", _imageName: "dabao.png")
        let appliance = Category(_name: "Fix me", _imageName: "repair.png")
        let queue = Category(_name: "Get queueing", _imageName: "queue.png")
        categoryArray.append(walkDog)
        categoryArray.append(dabao)
        categoryArray.append(appliance)
        categoryArray.append(queue)
        
    }
    

}


extension CategoryCollectionViewController:UICollectionViewDelegateFlowLayout
{
    
    func collectionView(_ collectionView:UICollectionView , layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
     
        let paddingSpace = sectionInserts.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInserts
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInserts.left
    }
    
    
}
