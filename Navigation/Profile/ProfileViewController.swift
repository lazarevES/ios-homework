//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Егор Лазарев on 08.02.2022.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {
        
    lazy var postTable: UITableView = {
        let postTable = UITableView(frame: .zero, style: .plain)
        postTable.toAutoLayout()
        postTable.refreshControl = UIRefreshControl()
        postTable.isScrollEnabled = true
        postTable.separatorInset = .zero
        postTable.refreshControl?.addTarget(self, action: #selector(updatePostArray), for: .valueChanged)
        postTable.rowHeight = UITableView.automaticDimension
        
        return postTable
    }()
    
    var posts = [FeedPost]()
    private let userService: UserService
    private let userName: String
    let coordinator: ProfileCoordinator
    
    init(coordinator: ProfileCoordinator, userService: UserService, name: String){
        self.userService = userService
        self.userName = name
        self.coordinator = coordinator
        self.posts = constPosts.filter({ $0.author == "Киря" })
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = LocalizableService.getText(key: .profile)
        
        let exitBarButton = UIBarButtonItem(title: LocalizableService.getText(key: .exit), style: .plain, target: self, action: #selector(exitToProfile))
        self.navigationItem.rightBarButtonItem  = exitBarButton
        
#if release
        view.backgroundColor = .lightGray
        postTable.backgroundColor = .lightGray
#elseif DEBUG
        view.backgroundColor = .white
        postTable.backgroundColor = .white
#endif
        
        postTable.dataSource = self
        postTable.delegate = self
        
        postTable.register(ProfileHeaderView.self, forHeaderFooterViewReuseIdentifier: ProfileHeaderView.identifire)
        postTable.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifire)
        postTable.register(PhotosTableViewCell.self, forCellReuseIdentifier: PhotosTableViewCell.identifire)
        
        view.addSubview(postTable)
        
        useConstraint()
        
    }
    
    func useConstraint() {
        NSLayoutConstraint.activate([postTable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                                     postTable.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                                     postTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                                     postTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    
    @objc func updatePostArray() {
        postTable.reloadData()
        postTable.refreshControl?.endRefreshing()
        showHeader()
    }
    
    func showHeader() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        DispatchQueue.global().async {
            sleep(3)
            DispatchQueue.main.async {
                self.dismisHeader()
            }
        }
    }
    
    func dismisHeader() {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    @objc func exitToProfile() {
        
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            coordinator.DissmisApp()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
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
            if let user = userService.getUser(name: userName) {
                headerView.initUserData(user: user)
            }
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
