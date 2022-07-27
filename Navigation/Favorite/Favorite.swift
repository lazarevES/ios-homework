//
//  Favorite.swift
//  Navigation
//
//  Created by Егор Лазарев on 26.07.2022.
//

import Foundation
import UIKit

class Favorite: UIViewController {
        
    var coordinator: FavoriteCoordinator
    var dbCoordinator: DatabaseCoordinatable
    
    lazy var postTable: UITableView = {
        let postTable = UITableView(frame: .zero, style: .plain)
        postTable.toAutoLayout()
        postTable.refreshControl = UIRefreshControl()
        postTable.isScrollEnabled = true
        postTable.separatorInset = .zero
        postTable.refreshControl?.addTarget(self, action: #selector(updatePostTable), for: .valueChanged)
        postTable.rowHeight = UITableView.automaticDimension
        
        return postTable
    }()
    
    lazy var searchButton: UIButton = {
        let button = UIButton()
        button.toAutoLayout()
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.setTitle("Поиск", for: .normal)
        button.titleLabel?.textColor = .white
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowOpacity = 0.7
        button.layer.shadowRadius = 4
        button.addTarget(self, action: #selector(SearchPost), for: .touchUpInside)
                
        if let image = UIImage(named: "blue_pixel") {
            button.imageView?.contentMode = .scaleAspectFill
            button.setBackgroundImage(image.imageWithAlpha(alpha: 1), for: .normal)
            button.setBackgroundImage(image.imageWithAlpha(alpha: 0.6), for: .selected)
            button.setBackgroundImage(image.imageWithAlpha(alpha: 0.6), for: .highlighted)
            button.setBackgroundImage(image.imageWithAlpha(alpha: 0.2), for: .disabled)
        }
        return button
    }()
    
    lazy var clearSearchButton: UIButton = {
        let button = UIButton()
        button.toAutoLayout()
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.setTitle("Очистить", for: .normal)
        button.titleLabel?.textColor = .white
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowOpacity = 0.7
        button.layer.shadowRadius = 4
        button.addTarget(self, action: #selector(cleanSearchPost), for: .touchUpInside)
                
        if let image = UIImage(named: "blue_pixel") {
            button.imageView?.contentMode = .scaleAspectFill
            button.setBackgroundImage(image.imageWithAlpha(alpha: 1), for: .normal)
            button.setBackgroundImage(image.imageWithAlpha(alpha: 0.6), for: .selected)
            button.setBackgroundImage(image.imageWithAlpha(alpha: 0.6), for: .highlighted)
            button.setBackgroundImage(image.imageWithAlpha(alpha: 0.2), for: .disabled)
        }
        return button
    }()
    
    lazy var searchNameLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.text = ""
        label.textAlignment = .natural
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    var searchName = "" {
        didSet {
            searchNameLabel.text = searchName
        }
    }
    var searchIsEnable = false
    var contentPostData: [FeedPost] = []
    
    init(coordinator: FavoriteCoordinator, dbCoordinator: DatabaseCoordinatable) {
        self.coordinator = coordinator
        self.dbCoordinator = dbCoordinator
        super.init(nibName: nil, bundle: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(removePostFromFavorites(_:)),
                                               name: .didRemovePostFromFavorites,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(addPostFromFavorites(_:)),
                                               name: .wasLikedPost,
                                               object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Избранное"
        
        view.addSubviews(postTable, searchButton, clearSearchButton, searchNameLabel)
        postTable.dataSource = self
        postTable.delegate = self
        postTable.register(FavoritePostCollectionViewCell.self, forCellReuseIdentifier: FavoritePostCollectionViewCell.identifire)
        getPost()
        useConstraint()
    }
    
    
    func useConstraint() {
        NSLayoutConstraint.activate([
            searchButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Const.leadingMargin),
            searchButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Const.indent),
            searchButton.heightAnchor.constraint(equalToConstant: Const.smallSize),
            searchButton.widthAnchor.constraint(equalToConstant: Const.bigSize),
            searchNameLabel.leadingAnchor.constraint(equalTo: searchButton.trailingAnchor, constant: Const.leadingMargin),
            searchNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Const.indent),
            searchNameLabel.heightAnchor.constraint(equalToConstant: Const.smallSize),
            clearSearchButton.leadingAnchor.constraint(equalTo: searchNameLabel.trailingAnchor, constant: Const.leadingMargin),
            clearSearchButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Const.indent),
            clearSearchButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: Const.trailingMargin),
            clearSearchButton.heightAnchor.constraint(equalToConstant: Const.smallSize),
            clearSearchButton.widthAnchor.constraint(equalToConstant: Const.bigSize),
            postTable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            postTable.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            postTable.topAnchor.constraint(equalTo: searchButton.bottomAnchor, constant: Const.indent),
            postTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)])
    }
    
    func getPost() {
        if searchIsEnable {
           let predicate = NSPredicate(format: "author == %@", searchName)
            self.dbCoordinator.fetch(FavoriteFeedPost.self, predicate: predicate) { result in
                switch result {
                case .success(let FavoriteFeedPost):
                    self.contentPostData = FavoriteFeedPost.map{ FeedPost(postCoreDataModel: $0) }
                    self.postTable.reloadData()
                case .failure(let error):
                    print("Ошибка загрузки из БД \(error)")
                }
            }
            
        } else {
            self.dbCoordinator.fetchAll(FavoriteFeedPost.self) { result in
                switch result {
                case .success(let FavoriteFeedPost):
                    self.contentPostData = FavoriteFeedPost.map{ FeedPost(postCoreDataModel: $0) }
                    self.postTable.reloadData()
                case .failure(let error):
                    print("Ошибка загрузки из БД \(error)")
                }
            }
        }
    }
    
    @objc func removePostFromFavorites(_ notification: NSNotification) {
        if let id = notification.userInfo?["id"] as? Int {
            self.contentPostData.removeAll(where: { $0.id == id } )
            self.postTable.reloadData()
        }
    }
    
    @objc func addPostFromFavorites(_ notification: NSNotification) {
        if let post = notification.userInfo?["post"] as? FeedPost {
            self.contentPostData.append(post)
            self.postTable.reloadData()
        }
    }
    
    @objc func SearchPost() {
        let alertController = UIAlertController(title: "Поиск по автору",
                                                message: "Введите имя автора",
                                                preferredStyle: .alert)
        
        alertController.addTextField( configurationHandler: {(textField: UITextField!) in
            textField.placeholder = "Киря"
        })
        
        let action = UIAlertAction(title: "Принять",
                                   style: UIAlertAction.Style.default) {[weak self] (paramAction:UIAlertAction!) in
            if let textFields = alertController.textFields {
                let theTextFields = textFields as [UITextField]
                let enteredText = theTextFields[0].text
                self?.searchName = enteredText ?? ""
                self?.searchIsEnable = true
                self?.getPost()
                
            }
        }
        
        alertController.addAction(action)
        
        self.present(alertController,
                     animated: true,
                     completion: nil)
    }
    
    @objc func cleanSearchPost() {
        self.searchIsEnable = false
        self.searchName = ""
        self.getPost()
    }
    
    private func removePostFromDatabase(_ post: FeedPost, using data:[FeedPost]) {
        let predicate = NSPredicate(format: "id == %ld", post.id)
        self.contentPostData.removeAll(where: { $0.id == Int(post.id) } )
        self.postTable.reloadData()
        
        NotificationCenter.default.post(name: .didRemovePostFromFavorites, object: nil, userInfo: ["id" : post.id])
        
        self.dbCoordinator.delete(FavoriteFeedPost.self, predicate: predicate) { result in
            
            switch result {
            case .success(_):
                print("запись удалена из бд")
            case .failure(let error):
                print("Ошибка удаления из бд \(error)")
            }
        }
    }
    
    @objc func updatePostTable() {
        getPost()
        postTable.refreshControl?.endRefreshing()
    }
}

extension Favorite: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        contentPostData.count

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = postTable.dequeueReusableCell(withIdentifier: FavoritePostCollectionViewCell.identifire, for: indexPath) as? FavoritePostCollectionViewCell
        else {
            preconditionFailure("Произошло какое то говно при открытии вашего профиля")
        }
        cell.setupPost(contentPostData[indexPath.row])
        cell.delegate = self
        return cell
    
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
       
        let post = contentPostData[indexPath.row]
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Удалить") { (_ , _, completionHandler) in
            
            let predicate = NSPredicate(format: "id == %ld", post.id)
            
            self.dbCoordinator.delete(FavoriteFeedPost.self, predicate: predicate) { result in
                switch result {
                case .success(_):
                    self.contentPostData.removeAll(where: { $0.id == Int(post.id) } )
                    tableView.deleteRows(at: [indexPath], with: .automatic)
                    NotificationCenter.default.post(name: .didRemovePostFromFavorites, object: nil, userInfo: ["id" : post.id])
                    completionHandler(true)
                case .failure(let error):
                    print("Ошибка удаления из бд \(error)")
                }
            }
            
        }
        let swipe = UISwipeActionsConfiguration(actions: [deleteAction])
        return swipe
    }
    
}

extension Favorite: FavoritePostCollectionViewCellDelegate {
    func showPost(post: FeedPost) {
        coordinator.showPost(post)
    }
    
    func tapToPost(with post: FeedPost) {
        self.removePostFromDatabase(post, using: [post])
    }
}
