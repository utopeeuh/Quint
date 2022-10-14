//
//  RatingView.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 14/10/22.
//

import Foundation
import UIKit
import SnapKit

class RatingView: UIView{
    
    var productId: Int!
    var isRated = 0
    
    private var thumbsUp: UIImageView!
    private var ratingNumber = UILabel()
    var thumbsUpView = UIView()
    private var seperator = UIView()
    var thumbsDown: UIImageView!

    static let ratedNone = 0
    static let ratedUp = 1
    static let ratedDown = 2
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        isUserInteractionEnabled = true
        configureUI()
        checkIfRated()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configureUI(){
        configureComponents()
        configureLayout()
    }
    
    func configureComponents(){
        backgroundColor = K.Color.whiteQuint
        layer.cornerRadius = 8
        
        let gestureUp = UITapGestureRecognizer(target: self, action:  #selector(self.rateOnClick))
    
        thumbsUp = UIImageView(image: UIImage(named: "ThumbsUpIcon"))
        
        ratingNumber.text = "69%"
        ratingNumber.font = .interSemi(size: 14)
        ratingNumber.textColor = K.Color.greenQuint
        ratingNumber.lineBreakMode = .byWordWrapping
        ratingNumber.numberOfLines = 0
        ratingNumber.frame = CGRect(x: 0, y: 0, width: 0, height: 16)
        ratingNumber.sizeToFit()
        
        thumbsUpView.tag = K.Rated.up
        thumbsUpView.isUserInteractionEnabled = true
        thumbsUpView.addGestureRecognizer(gestureUp)
        
        thumbsUpView.addSubview(thumbsUp)
        thumbsUpView.addSubview(ratingNumber)
        
        seperator.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
        
        let gestureDown = UITapGestureRecognizer(target: self, action:  #selector(self.rateOnClick))
        
        thumbsDown = UIImageView(image: UIImage(named: "ThumbsDownIcon"))
        thumbsDown.tag = 2
        thumbsDown.isUserInteractionEnabled = true
        thumbsDown.addGestureRecognizer(gestureDown)
    }
    
    func configureLayout(){
        self.addSubview(thumbsUpView)
        self.addSubview(seperator)
        self.addSubview(thumbsDown)
        
        self.snp.makeConstraints { make in
            make.height.equalTo(37)
            make.width.equalTo(84+ratingNumber.frame.width)
//            make.width.equalTo(200)
        }
        
        thumbsUpView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(8)
            make.width.equalTo(18+ratingNumber.frame.width)
            make.height.equalTo(21)
        }
        
        thumbsUp.snp.makeConstraints { make in
            make.top.left.equalToSuperview()
            make.height.equalTo(18)
            make.width.equalTo(18)
        }
        
        ratingNumber.snp.makeConstraints { make in
            make.centerY.equalTo(thumbsUp)
            make.left.equalTo(thumbsUp.snp.right).offset(4)
        }
        
        seperator.snp.makeConstraints { make in
            make.left.equalTo(ratingNumber.snp.right).offset(10)
            make.top.equalToSuperview().offset(8)
            make.width.equalTo(1)
            make.height.equalTo(20)
        }
        
        thumbsDown.snp.makeConstraints { make in
            make.centerY.equalTo(seperator)
            make.right.equalToSuperview().offset(-10)
        }
    }
    
    @objc func rateOnClick(_ sender: UITapGestureRecognizer){
        
        print("rate")
        
        // if sender is thumbs up
        if(sender.view == thumbsUpView){
            if(isRated == K.Rated.up){
                uncheck(thumbsUpView)
                isRated = K.Rated.none
            }
            else{
                check(thumbsUpView)
                uncheck(thumbsDown)
                isRated = K.Rated.up
            }
        }
        
        if(sender.view == thumbsDown){
            if(isRated == K.Rated.down){
                uncheck(thumbsDown)
                isRated = K.Rated.none
            }
            else{
                check(thumbsDown)
                uncheck(thumbsUpView)
                isRated = K.Rated.down
            }
        }
    }
    
    func checkIfRated(){
        // change to filled here if checked
        // 0 - not | 1 - up | 2 - down
        switch(isRated){
            case 1: check(thumbsUpView)
            case 2: check(thumbsDown)
            default: return
        }
    }
    
    func check(_ sender: UIView){
        if sender == thumbsUpView{
            thumbsUp.image = UIImage(named: "ThumbsUpFilledIcon")
        }
        
        if sender == thumbsDown{
            thumbsDown.image = UIImage(named: "ThumbsDownFilledIcon")
        }
    }
    
    func uncheck(_ sender: UIView){
        if sender == thumbsUpView{
            thumbsUp.image = UIImage(named: "ThumbsUpIcon")
        }
        
        if sender == thumbsDown{
            thumbsDown.image = UIImage(named: "ThumbsDownIcon")
        }
    }
}
