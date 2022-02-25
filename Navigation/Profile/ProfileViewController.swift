//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Егор Лазарев on 08.02.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var isLogined = true
    var postTable: UITableView = {
        let postTable = UITableView(frame: .zero, style: .grouped)
        postTable.toAutoLayout()
        postTable.refreshControl = UIRefreshControl()
        postTable.isScrollEnabled = true
        postTable.separatorInset = .zero
        postTable.refreshControl?.addTarget(self, action: #selector(updatePostArray), for: .valueChanged)
        postTable.sectionHeaderHeight = UITableView.automaticDimension
        postTable.estimatedSectionHeaderHeight = 220
        postTable.rowHeight = UITableView.automaticDimension
        //postTable.estimatedRowHeight = 44
        
        return postTable
    }()
    
    var posts = constPostArray
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Профиль"
        
        view.backgroundColor = .white
        
        postTable.dataSource = self
        postTable.delegate = self
        
        postTable.register(ProfileHeaderView.self, forHeaderFooterViewReuseIdentifier: ProfileHeaderView.identifire)
        postTable.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifire)
        
        view.addSubview(postTable)
        
        useConstraint()
        
    }
    
    func useConstraint() {
        [postTable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
         postTable.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
         postTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
         postTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)].forEach({$0.isActive = true})
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidAppear (_ animated: Bool) {
        
        isLogined = !isLogined
        
        if !isLogined {
            navigationController?.pushViewController(LogInViewController(), animated: true)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @objc func updatePostArray() {
        postTable.reloadData()
        postTable.refreshControl?.endRefreshing()
    }
    
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.posts.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifire, for: indexPath) as! PostTableViewCell
        cell.specifyFields(post: posts[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 0 {
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: ProfileHeaderView.identifire) as! ProfileHeaderView
            return headerView
        } else { return nil }
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 220
    }
        
}
