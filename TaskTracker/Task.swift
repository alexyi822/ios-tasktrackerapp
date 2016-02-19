//
//  Task.swift
//  TaskTracker
//
//  Created by Alex Yi on 2/18/16.
//  Copyright © 2016 Alex Yi. All rights reserved.
//

import UIKit

class Task {
    
    // MARK: Properties
    var name: String
    var comments: String?
    var priority: String
    
    
    // MARK: Initialization
    init?(name: String, comments: String?, priority: String){
        self.name = name
        self.comments = comments
        self.priority = priority
        
        if name.isEmpty {
            return nil
        }
        
        
    }
    
    
}
