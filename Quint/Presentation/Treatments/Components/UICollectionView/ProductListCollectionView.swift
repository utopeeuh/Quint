//
//  ProductListCollectionView.swift
//  DynamicCell
//
//  Created by Mohannad on 29.03.2021.
//

import UIKit

@available(iOS 16.0, *)
class ProductListCollectionView: UIView {

    var feedCollection: UICollectionView!
    
    var source : [ProductModel] = []
    
    var photos = [Photo]()
    
    var height : CGFloat = 0
    private var colOneHeight : CGFloat = 0
    private var colTwoHeight : CGFloat = 0
    
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
        feedCollection.register(ProductListCell.self, forCellWithReuseIdentifier: "ProductListCell")
        feedCollection.backgroundColor = K.Color.bgQuint
        feedCollection.dataSource = self
        feedCollection.showsVerticalScrollIndicator = false
        feedCollection.isScrollEnabled = false
        
        self.addSubview(feedCollection)
        feedCollection.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalToSuperview()
        }
        
        ApiService.shared.getPhotos { (res) in
            
            if let photos = res {
                
                DispatchQueue.main.async {
                    
                    self.photos = photos
                    
                    self.feedCollection.reloadData()
                }
            }
        }
    }
    
    func setSource(_ source: [ProductModel], completion: @escaping () -> () = {}){
    
        height = 0
        colOneHeight = 0
        colTwoHeight = 0
        
        self.source = source
        
        self.feedCollection.reloadData()
        self.feedCollection.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: height)
        
        let layout = PinterestLayout()
        layout.delegate = self
        self.feedCollection.collectionViewLayout = layout
        
        completion()
    }
}

@available(iOS 16.0, *)
extension ProductListCollectionView : UICollectionViewDataSource , UICollectionViewDelegate  {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return source.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductListCell", for: indexPath) as! ProductListCell

        let product = source[indexPath.row]
        
        // Set product photo
        let productPhoto = Photo(String(describing: product.id), 150, "", product.image)
        cell.info = productPhoto
        
        // Set product
        cell.product = product
        
        return cell
    }
}

@available(iOS 16.0, *)
extension ProductListCollectionView : PinterestLayoutDelegate {
   
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath, cellWidth: CGFloat) -> CGFloat {
        
        let cell = ProductListCell()
        cell.product = source[indexPath.row]
        
        let cellHeight = (166 + cell.nameLabel.requiredHeight + cell.brandLabel.requiredHeight + 36 + 68)
        
        // If on col 1
        if (indexPath.row % 2 != 0){
            colOneHeight += cellHeight
        }
        // If on col 2
        else {
            colTwoHeight += cellHeight
        }
        
        // Current is last, determine which column is taller
        if (indexPath.row == source.count-1){
            height = colOneHeight > colTwoHeight ? colOneHeight : colTwoHeight
        }
        
        return cellHeight
    }
}
