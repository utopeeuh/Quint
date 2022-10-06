//
//  ProductListCollectionView.swift
//  DynamicCell
//
//  Created by Mohannad on 29.03.2021.
//

import UIKit
import Fakery

class ProductListCollectionView: UIView {

    var feedCollection: UICollectionView!
    
    var photos = [Photo]()
    
    var headers = [String]()
    
    override init(frame: CGRect){
        super.init(frame: frame)
     
//        buildHeaders()
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
        feedCollection.register(ProductListCell.self, forCellWithReuseIdentifier: "ProductListCell")
        feedCollection.backgroundColor = K.Color.bgQuint
        feedCollection.dataSource = self
        feedCollection.showsVerticalScrollIndicator = false
        feedCollection.toggleActivityIndicator()
        
        self.addSubview(feedCollection)
        feedCollection.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalToSuperview()
        }
    
        
        ApiService.shared.getPhotos { (res) in
            
            if let photos = res {
                
                DispatchQueue.main.async {
                    
                    self.feedCollection.toggleActivityIndicator()
                    
                    self.photos = photos
                    
                    self.feedCollection.reloadData()
                }
            }
        }
    }
    
    func buildHeaders(){
        
//        let faker = Faker(locale: "nb-NO")
//        for i in 0...50 {
//            let randomInt = Int(arc4random_uniform(13) + 2)
//            let text = faker.lorem.words(amount: randomInt)
//            headers.append(text)
//        }
    }
}

extension ProductListCollectionView : UICollectionViewDataSource , UICollectionViewDelegate  {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductListCell", for: indexPath) as! ProductListCell

        cell.info = photos[indexPath.row]
        let dummyPhoto = Photo("1", 100, "", "https://www.soco.id/cdn-cgi/image/w=150,format=auto,dpr=1.45/https://images.soco.id/29fbc95c-e81a-4afb-8c68-57530c3d7a94-.jpg")
        cell.info = dummyPhoto
        if(indexPath.row % 2 == 0){
            cell.nameLabel.text = "Ini nama panjang cuma buat testing ya harusnya udh dynamic"
        }
        else{
            cell.nameLabel.text = "ini nama pendek aja"
        }
        
        cell.brandLabel.text = "Innisfree"
        
        return cell
        
    }

}

extension ProductListCollectionView : PinterestLayoutDelegate {
   
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath, cellWidth: CGFloat) -> CGFloat {
        
//        let imgHeight = calculateImageHeight(sourceImage: photos[indexPath.row] , scaledToWidth: cellWidth)
//
//        let textHeight = requiredHeight(text: headers[indexPath.row], cellWidth: (cellWidth - 10))
        var nameHeight: CGFloat!
        var brandHeight: CGFloat!
        
        if(indexPath.row % 2 == 0){
            nameHeight = requiredHeight(text: "Ini nama panjang cuma buat testing ya harusnya udh dynamic", cellWidth: cellWidth, isBrand: false)
            brandHeight = requiredHeight(text: "Innisfree", cellWidth: cellWidth, isBrand: true)
        }
        else{
            nameHeight = requiredHeight(text: "ini nama pendek aja", cellWidth: cellWidth, isBrand: false)
            brandHeight = requiredHeight(text: "Innisfree", cellWidth: cellWidth, isBrand: true)
        }
    
        //img height + text heights + text offsets + img offset + rating offset
        return (150+nameHeight+brandHeight+86)
    }
    
    func requiredHeight(text:String , cellWidth : CGFloat, isBrand: Bool) -> CGFloat {
        let font: UIFont!
        if(isBrand){
            font = UIFont.systemFont(ofSize: 13)
        }
        else{
            font = UIFont.systemFont(ofSize: 16)
        }
        
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: cellWidth-24, height: .greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        return label.frame.height
    }
}
