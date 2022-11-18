//
//  RatingRepository.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 17/11/22.
//

import Foundation
import FirebaseFirestore

protocol RatingRepositoryDelegate{
    func updateRating(rating: RatingModel, upvote: Bool, undo: Bool) async
    func fetchRatings(productId: Int) async -> RatingModel?
}

class RatingRepository: RatingRepositoryDelegate{
    
    let settings = FirestoreSettings()
    let db = Firestore.firestore()
    var rootRating: CollectionReference
    
    static let shared = RatingRepository()
        
    init(){
        Firestore.firestore().settings = settings
        rootRating = db.collection("ratings")
    }
    
    func updateRating(rating: RatingModel, upvote: Bool, undo: Bool) async {
        
        do {
            let currUser = UserRepository.shared.fetchUser()
            let snapshot = try await rootRating
                                    .whereField("productId", isEqualTo: rating.productId)
                                    .whereField("skinTypeId", isEqualTo: currUser.skinTypeId)
                                    .getDocuments()
            
            if let document = snapshot.documents.first {
                if upvote {
                    // thumbs up
                    if undo {
                        try await document.reference.updateData(["thumbsUp": rating.thumbsUp-1])
                        print(rating.thumbsUp-1)
                    }
                    
                    else {
                        try await document.reference.updateData(["thumbsUp": rating.thumbsUp+1])
                    }
                    
                } else {
                    // thumbs down
                    if undo {
                        try await document.reference.updateData(["thumbsDown": rating.thumbsDown-1])
                    }
                    
                    else {
                        try await document.reference.updateData(["thumbsDown": rating.thumbsDown+1])
                    }
                    
                }
            }
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }

    func fetchRatings(productId: Int) async -> RatingModel? {
        var rating: RatingModel?
        
        do {
            let currUser = UserRepository.shared.fetchUser()
            let snapshot = try await rootRating
                                    .whereField("productId", isEqualTo: productId)
                                    .whereField("skinTypeId", isEqualTo: currUser.skinTypeId)
                                    .getDocuments()
            
            if let document = snapshot.documents.first {
                let thumbsUp = document.get("thumbsUp") as? Int
                let thumbsDown = document.get("thumbsDown") as? Int
                
                rating = RatingModel(productId: productId)
                rating?.thumbsUp = thumbsUp ?? 0
                rating?.thumbsDown = thumbsDown ?? 0
                return rating
            }
            
        } catch {
            print("Error: \(error.localizedDescription)")
        }
        
        return nil
    }
    
    func createRating(productId: Int) async -> Bool {
        
        var success = false
        
        do {
            let currUser = UserRepository.shared.fetchUser()
            
            let newRatingRef = rootRating.document()
            
            try await newRatingRef.setData([
                                        "productId": productId,
                                        "thumbsUp": 0,
                                        "thumbsDown": 0,
                                        "skinTypeId": currUser.skinTypeId])
            
            success = true
            
        } catch {
            print("Error: \(error.localizedDescription)")
        }
        
        return success
    }
    
}
