//
//  RepoTableViewModel.swift
//  MVVM
//
//  Created by Anuran Barman on 8/27/18.
//  Copyright © 2018 Anuran Barman. All rights reserved.
//

import Foundation
class RepoTableViewModel {
    
    var apiService:ApiService
    
    private var repos:[Repo] = [Repo]()
    private var cellViewModels:[RepoTableViewCellViewModel] = [RepoTableViewCellViewModel]() {
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    
    var numberOfCells: Int {
        return cellViewModels.count
    }
    
    var reloadTableViewClosure: (()->())?
    
    
    init(apiService:ApiService = ApiService()) {
        self.apiService=apiService
    }
    
    func initFetch() {
        
        apiService.fetchAllRepo { (success, repos, error) in
            if(error == "") {
                self.processFetchedRepo(repos: repos)
            }else{
                print("Error")
            }
        }
    }
    
    func getCellViewModel( at indexPath: IndexPath ) -> RepoTableViewCellViewModel {
        return cellViewModels[indexPath.row]
    }
    
    func createCellViewModel( repo: Repo ) -> RepoTableViewCellViewModel {
        
    
        return RepoTableViewCellViewModel( name: repo.name,
                                       url: repo.url,
                                       desc: repo.desc!,
                                       starCount: repo.starCount,
                                       forkCount:repo.forkCount)
    }
    
    private func processFetchedRepo( repos: [Repo] ) {
        self.repos = repos // Cache
        var vms = [RepoTableViewCellViewModel]()
        for repo in repos {
            vms.append( createCellViewModel(repo: repo) )
        }
        self.cellViewModels = vms
    }
    
}
