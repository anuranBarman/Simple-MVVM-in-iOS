//
//  Repo.swift
//  MVVM
//
//  Created by Anuran Barman on 8/27/18.
//  Copyright © 2018 Anuran Barman. All rights reserved.
//

import Foundation

class Repo {

    let name:String
    let url:String
    let desc:String?
    let starCount:Int
    let forkCount:Int
    
    init(name:String,url:String,desc:String,starCount:Int,forkCount:Int) {
        self.name=name
        self.url=url
        self.desc=desc
        self.starCount=starCount
        self.forkCount=forkCount
    }
    
}
