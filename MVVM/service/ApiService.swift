//
//  ApiService.swift
//  MVVM
//
//  Created by Anuran Barman on 8/27/18.
//  Copyright © 2018 Anuran Barman. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ApiService {
    
    init() {
        
    }
    
    func fetchAllRepo(onResult:@escaping (_ success:Int,_ repos:[Repo],_ error:String)->()){
        Alamofire.request("https://api.github.com/users/anuranBarman/repos").responseJSON { response in
            
            if let json = response.data {
                var repos:[Repo]=[]
                do {
                    let data = try JSON(data:json)
                    for i in 0..<data.count {
                        let repo = data[i]
                        let nameRepo = repo["name"]
                        let url = repo["html_url"]
                        let desc = repo["description"] == nil ? "" : repo["description"]
                        let starCount = repo["stargazers_count"]
                        let forkCount = repo["forks_count"]
                        print("\(url)")
                        repos.append(Repo(name: nameRepo.string!, url: url.string!, desc: desc.string!, starCount: starCount.int!, forkCount: forkCount.int!))
                    }
                    onResult(0,repos,"")
                }catch{
                    
                }
                
            }
        
        }
        
    }
    
}
