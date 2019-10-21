//
//  CommentNetwork.swift
//  GithubIssue
//
//  Created by nhat on 10/21/19.
//  Copyright © 2019 nhat. All rights reserved.
//

import Foundation
import Apollo

final class CommentNetwork {
    
    // MARK: - Attributes
    
    let network: ApolloNetwork
    
    // MARK: - Initializers
    
    init(network: ApolloNetwork = ApolloNetwork()) {
        self.network = network
    }
    
    
    // MARK: - Functions
    
    func addCommentIssue(subjectID: String,
                         bodyString: String,
                         completionHandler: @escaping (Error?) -> Void) {
        let mutation = AddCommentToIssueMutation(id: subjectID, body: bodyString)
        
        network.client.perform(mutation: mutation) { (result) in
            switch result {
            case .success:
                completionHandler(nil)
            case .failure(let error):
                completionHandler(error)
            }
        }
    }
    
    func editCommentIssue(subjectID: String,
                          bodyString: String,
                          completionHandler: @escaping (Error?) -> Void) {
        let mutation = EditCommentIssueMutation(id: subjectID, body: bodyString)
        
        network.client.perform(mutation: mutation) { (result) in
            switch result {
            case .success:
                completionHandler(nil)
            case .failure(let error):
                completionHandler(error)
            }
        }
    }
    
    func deleteCommentIssue(subjectID: String,
                            completionHandler: @escaping (Error?) -> Void) {
         let mutation = DeleteCommentIssueMutation(id: subjectID)
         
         network.client.perform(mutation: mutation) { (result) in
             switch result {
             case .success:
                 completionHandler(nil)
             case .failure(let error):
                 completionHandler(error)
             }
         }
     }
}
