//
//  ProgressCollectionView.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 06/12/22.
//

import Foundation
import UIKit

class ProgressCollectionView: UIView {

    private var feedCollection: UICollectionView!
    private var source : [LogModel] = []
    
    override init(frame: CGRect){
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override func configure(){
        
        let layout = ProgressLayout()
        layout.delegate = self
        self.backgroundColor = K.Color.bgQuint
        
        feedCollection = UICollectionView(frame: self.frame, collectionViewLayout: layout)
        feedCollection.register(ProgressCell.self, forCellWithReuseIdentifier: "ProgressCell")
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
    
    func setSource(_ source: [LogModel]){
        self.source = source
        feedCollection.reloadData()
        feedCollection.setContentOffset(CGPoint(x: 0.0, y: 0.0), animated: true)
    }
    
    func getCount() -> Int{
        return source.count
    }
}

extension ProgressCollectionView : UICollectionViewDataSource , UICollectionViewDelegate  {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return source.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let controller = IngredientDetailVC()
//        controller.ingredient = source[indexPath.row]
//        (superview?.next as? UIViewController)?.navigationController?.pushViewController(controller, animated: true)
//
//        (superview?.superview?.superview?.superview?.next as? UIViewController)?.navigationController?.pushViewController(controller, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProgressCell", for: indexPath) as! ProgressCell

        cell.setLog(log: source[indexPath.row])
        return cell
    }
}

extension ProgressCollectionView : ProgressLayoutDelegate {
   
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath, cellWidth: CGFloat) -> CGFloat {
    
        return ((UIScreen.main.bounds.width-60)/3*159/110)+30
    }
}
