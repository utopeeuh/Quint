//
//  ProductListCollectionView.swift
//  DynamicCell
//
//  Created by Mohannad on 29.03.2021.
//

import UIKit

class IngredientListCollectionView: UIView {

    var feedCollection: UICollectionView!
    var source = K.Dummy.ingredient
    
    override init(frame: CGRect){
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func configureUI(){
        
        let layout = PinterestLayout()
        layout.delegate = self
        self.backgroundColor = K.Color.bgQuint
        
        feedCollection = UICollectionView(frame: self.frame, collectionViewLayout: layout)
        feedCollection.register(IngredientListCell.self, forCellWithReuseIdentifier: "IngredientListCell")
        feedCollection.backgroundColor = K.Color.bgQuint
        feedCollection.dataSource = self
        feedCollection.showsVerticalScrollIndicator = false
        
        self.addSubview(feedCollection)
        feedCollection.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalToSuperview()
        }
    }
    
    func setSource(_ source: [Int: String]){
        self.source = source
        self.feedCollection.reloadData()
    }
    
    func getCount() -> Int{
        return source.count*3
    }
}

extension IngredientListCollectionView : UICollectionViewDataSource , UICollectionViewDelegate  {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return source.count*3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IngredientListCell", for: indexPath) as! IngredientListCell

        cell.nameLabel.text = source[2]!
        return cell
    }
}

extension IngredientListCollectionView : PinterestLayoutDelegate {
   
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath, cellWidth: CGFloat) -> CGFloat {
    
        return (88)
    }
}
