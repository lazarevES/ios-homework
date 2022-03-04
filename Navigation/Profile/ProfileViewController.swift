//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Егор Лазарев on 08.02.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var isLogined = true
    
    static var postTable: UITableView = {
        let postTable = UITableView(frame: .zero, style: .plain)
        postTable.toAutoLayout()
        postTable.refreshControl = UIRefreshControl()
        postTable.isScrollEnabled = true
        postTable.separatorInset = .zero
        postTable.refreshControl?.addTarget(self, action: #selector(updatePostArray), for: .valueChanged)
        postTable.rowHeight = UITableView.automaticDimension
        
        return postTable
    }()
    
    var posts = constPostArray
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Профиль"
        
        view.backgroundColor = .white
        
        ProfileViewController.postTable.dataSource = self
        ProfileViewController.postTable.delegate = self
        
        ProfileViewController.postTable.register(ProfileHeaderView.self, forHeaderFooterViewReuseIdentifier: ProfileHeaderView.identifire)
        ProfileViewController.postTable.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifire)
        ProfileViewController.postTable.register(PhotosTableViewCell.self, forCellReuseIdentifier: PhotosTableViewCell.identifire)
        
        view.addSubview(ProfileViewController.postTable)
        
        useConstraint()
        
    }
    
    func useConstraint() {
        [ProfileViewController.postTable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
         ProfileViewController.postTable.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
         ProfileViewController.postTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
         ProfileViewController.postTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)].forEach({$0.isActive = true})
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
        ProfileViewController.postTable.reloadData()
        ProfileViewController.postTable.refreshControl?.endRefreshing()
    }
    
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        section == 1 ? self.posts.count : 1

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifire, for: indexPath) as! PostTableViewCell
            cell.specifyFields(post: posts[indexPath.row])
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: PhotosTableViewCell.identifire, for: indexPath) as! PhotosTableViewCell
        return cell
    
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 0 {
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: ProfileHeaderView.identifire) as! ProfileHeaderView
            return headerView
        } else
        { return nil }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            if section == 0 {
                return 220
            } else {
                return 0
            }
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           if indexPath.section == 0 {
               navigationController?.pushViewController(PhotosViewController(), animated: true)
           }
       }
    
}
