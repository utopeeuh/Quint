//
//  ProductListCollectionView.swift
//  DynamicCell
//
//  Created by Mohannad on 29.03.2021.
//

import UIKit

class IngredientListCollectionView: UIView {

    private var feedCollection: UICollectionView!
    private var source : [IngredientModel] = []
    
    override init(frame: CGRect){
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override func configure(){
        
        let layout = PinterestLayout()
        layout.delegate = self
        self.backgroundColor = K.Color.bgQuint
        
        feedCollection = UICollectionView(frame: self.frame, collectionViewLayout: layout)
        feedCollection.register(IngredientListCell.self, forCellWithReuseIdentifier: "IngredientListCell")
        feedCollection.backgroundColor = K.Color.bgQuint
        feedCollection.dataSource = self
        feedCollection.delegate = self
        feedCollection.showsVerticalScrollIndicator = false
        
        self.addSubview(feedCollection)
        feedCollection.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalToSuperview()
        }
    }
    
    func setSource(_ source: [IngredientModel]){
        self.source = source
        feedCollection.reloadData()
        feedCollection.setContentOffset(CGPoint(x: 0.0, y: 0.0), animated: true)
    }
    
    func getCount() -> Int{
        return source.count
    }
}

extension IngredientListCollectionView : UICollectionViewDataSource , UICollectionViewDelegate  {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return source.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = IngredientDetailVC()
        controller.ingredient = source[indexPath.row]
        (superview?.next as? UIViewController)?.navigationController?.pushViewController(controller, animated: true)
        
        (superview?.superview?.superview?.superview?.next as? UIViewController)?.navigationController?.pushViewController(controller, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IngredientListCell", for: indexPath) as! IngredientListCell

        cell.nameLabel.text = source[indexPath.row].name
        return cell
    }
}

extension IngredientListCollectionView : PinterestLayoutDelegate {
   
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath, cellWidth: CGFloat) -> CGFloat {
    
        return (88)
    }
}
