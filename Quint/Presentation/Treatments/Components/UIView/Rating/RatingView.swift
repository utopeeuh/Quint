//
//  RatingView.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 14/10/22.
//

import Foundation
import UIKit
import SnapKit

protocol RatingViewDelegate{
    func displayRating(width: Int)
}

class RatingView: UIView{
    
    var productId: Int!
    var isRated = 0
    var rating: RatingModel?
    
    var height = 37
    var width = 121
    
    var delegate: RatingViewDelegate?
    
    private var thumbsUp: UIImageView!
    private var thumbsUpValue = UILabel()
    private var thumbsUpView = UIView()
    
    private var seperator = UIView()
    
    private var thumbsDown: UIImageView!
    private var thumbsDownValue = UILabel()
    private var thumbsDownView = UIView()
    
    init(productId: Int) {
        super.init(frame: .zero)
        
        self.productId = productId
        isUserInteractionEnabled = true
        alpha = 0
        
        // fetch rating
        Task{
            rating = await RatingRepository.shared.fetchRatings(productId: productId)
            
            if(rating?.thumbsUp == nil){
                let success = await RatingRepository.shared.createRating(productId: productId)
                
                if success {
                    rating = await RatingRepository.shared.fetchRatings(productId: productId)
                }
            }
            
            delegate?.displayRating(width: width)
            configureUI()
            checkIfRated()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    override func configureComponents(){
        backgroundColor = K.Color.whiteQuint
        layer.cornerRadius = 8
        
        let gestureUp = UITapGestureRecognizer(target: self, action:  #selector(self.rateOnClick))
    
        thumbsUp = UIImageView(image: UIImage(named: "ThumbsUpIcon"))
        
        let thumbsUpText = rating == nil ? "-" : String(describing: rating!.thumbsUp)
        thumbsUpValue.text = thumbsUpText
        thumbsUpValue.font = .interSemiBold(size: 14)
        thumbsUpValue.textColor = K.Color.greenQuint
        thumbsUpValue.lineBreakMode = .byWordWrapping
        thumbsUpValue.numberOfLines = 0
        thumbsUpValue.frame = CGRect(x: 0, y: 0, width: 0, height: 16)
        thumbsUpValue.sizeToFit()
        
        thumbsUpView.tag = K.Rated.up
        thumbsUpView.isUserInteractionEnabled = true
        thumbsUpView.addGestureRecognizer(gestureUp)
        thumbsUpView.addSubview(thumbsUp)
        thumbsUpView.addSubview(thumbsUpValue)
        
        seperator.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
        seperator.isUserInteractionEnabled = false
        
        let gestureDown = UITapGestureRecognizer(target: self, action:  #selector(self.rateOnClick))
        
        thumbsDown = UIImageView(image: UIImage(named: "ThumbsDownIcon"))
        
        let thumbsDownText = rating == nil ? "-" : String(describing: rating!.thumbsDown)
        thumbsDownValue.text = thumbsDownText
        thumbsDownValue.font = .interSemiBold(size: 14)
        thumbsDownValue.textColor = K.Color.greenQuint
        thumbsDownValue.lineBreakMode = .byWordWrapping
        thumbsDownValue.numberOfLines = 0
        thumbsDownValue.frame = CGRect(x: 0, y: 0, width: 0, height: 16)
        thumbsDownValue.sizeToFit()
        
        thumbsDownView.tag = K.Rated.up
        thumbsDownView.isUserInteractionEnabled = true
        thumbsDownView.addGestureRecognizer(gestureDown)
        thumbsDownView.addSubview(thumbsDown)
        thumbsDownView.addSubview(thumbsDownValue)
    }
    
    override func configureLayout(){

        multipleSubviews(view: thumbsUpView, seperator, thumbsDownView)
        
        subviews.forEach { view in
            view.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
            }
            
            view.subviews.forEach { subview in
                subview.snp.makeConstraints { make in
                    make.centerY.equalToSuperview()
                }
                subview.isUserInteractionEnabled = false
            }
        }
        
        thumbsUpView.snp.makeConstraints { make in
            make.top.left.bottom.equalToSuperview()
            make.right.equalTo(seperator.snp.left)
        }
        
        thumbsUp.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.size.equalTo(18)
        }
        
        thumbsUpValue.snp.makeConstraints { make in
            make.right.equalTo(seperator.snp.left).offset(-10)
        }
        
        seperator.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(1)
            make.height.equalTo(20)
        }
        
        thumbsDownView.snp.makeConstraints { make in
            make.left.equalTo(seperator.snp.right)
            make.top.right.bottom.equalToSuperview()
        }
        
        thumbsDownValue.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10)
        }
        
        thumbsDown.snp.makeConstraints { make in
            make.size.equalTo(18)
            make.left.equalTo(seperator.snp.right).offset(10)
        }
        
        UIView.animate(withDuration: 0.2) {
            self.alpha = 1
        }
    }
    
    @objc func rateOnClick(_ sender: UITapGestureRecognizer){
        
        print("rate")
        
        // if sender is thumbs up
        if(sender.view == thumbsUpView){
            if(isRated == K.Rated.up){
                uncheck(thumbsUpView)
                isRated = K.Rated.none
                Task {
                    await RatingRepository.shared.updateRating(rating: rating!, upvote: true, undo: true)
                    RatingCoreRepository.shared.setRated(productId: productId, rated: K.Rated.none)
                }
                
                setThumbsUpValue(add: false)
                
            }
            else{
                check(thumbsUpView)
                uncheck(thumbsDownView)
                
                if(isRated == K.Rated.down){
                    setThumbsDownValue(add: false)
                    Task {
                        await RatingRepository.shared.updateRating(rating: rating!, upvote: false, undo: true)
                    }
                }
                
                isRated = K.Rated.up
                Task {
                    await RatingRepository.shared.updateRating(rating: rating!, upvote: true, undo: false)
                    
                    RatingCoreRepository.shared.setRated(productId: productId, rated: K.Rated.up)
                    RatingCoreRepository.shared.setRated(productId: productId, rated: K.Rated.up)
                }
                
                setThumbsUpValue(add: true)
            }
        }
        
        if(sender.view == thumbsDownView){
            if(isRated == K.Rated.down){
                
                uncheck(thumbsDownView)
                isRated = K.Rated.none
                
                Task {
                    await RatingRepository.shared.updateRating(rating: rating!, upvote: false, undo: true)
                    
                    RatingCoreRepository.shared.setRated(productId: productId, rated: K.Rated.none)
                }
                
                setThumbsDownValue(add: false)
            }
            else{
                check(thumbsDownView)
                uncheck(thumbsUpView)
                
                if isRated == K.Rated.up {
                    setThumbsUpValue(add: false)
                    Task {
                        await RatingRepository.shared.updateRating(rating: rating!, upvote: true, undo: true)
                    }
                }
                
                isRated = K.Rated.down
                Task {
                    await RatingRepository.shared.updateRating(rating: rating!, upvote: false, undo: false)
                    
                    RatingCoreRepository.shared.setRated(productId: productId, rated: K.Rated.down)
                }
                setThumbsDownValue(add: true)
            }
        }
    }
    
    func setThumbsUpValue(add: Bool){
        if add {
            thumbsUpValue.text = "\(Int(thumbsUpValue.text ?? "0")! + 1)"
        } else {
            thumbsUpValue.text = "\(Int(thumbsUpValue.text ?? "0")! - 1)"
        }
    }
    
    func setThumbsDownValue(add: Bool){
        if add {
            thumbsDownValue.text = "\(Int(thumbsDownValue.text ?? "0")! + 1)"
        } else {
            thumbsDownValue.text = "\(Int(thumbsDownValue.text ?? "0")! - 1)"
        }
    }
    
    func checkIfRated(){
        // change to filled here if checked
        isRated = RatingCoreRepository.shared.getRated(productId: productId)
        
        switch(isRated){
        case K.Rated.up: check(thumbsUpView)
        case K.Rated.down: check(thumbsDownView)
        default: return
        }
    
    }
    
    func check(_ sender: UIView){
        if sender == thumbsUpView{
            thumbsUp.image = UIImage(named: "ThumbsUpFilledIcon")
        }
        
        if sender == thumbsDownView{
            thumbsDown.image = UIImage(named: "ThumbsDownFilledIcon")
        }
    }
    
    func uncheck(_ sender: UIView){
        if sender == thumbsUpView{
            thumbsUp.image = UIImage(named: "ThumbsUpIcon")
        }
        
        if sender == thumbsDownView{
            thumbsDown.image = UIImage(named: "ThumbsDownIcon")
        }
    }
}
