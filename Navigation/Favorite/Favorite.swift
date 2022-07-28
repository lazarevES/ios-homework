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
    
    lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        layout.scrollDirection = .vertical
        return layout
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.toAutoLayout()
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
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
        
        title = "Новости"
        
        view.addSubview(collectionView)
        collectionView.register(FavoritePostCollectionViewCell.self, forCellWithReuseIdentifier: FavoritePostCollectionViewCell.identifire)
        getPost()
        useConstraint()
    }
    
    
    func useConstraint() {
        NSLayoutConstraint.activate([collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                                     collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                                     collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                                     collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)])
    }
    
    func getPost() {
        self.dbCoordinator.fetchAll(FavoriteFeedPost.self) { result in
            switch result {
            case .success(let FavoriteFeedPost):
                self.contentPostData = FavoriteFeedPost.map{ FeedPost(PostCoreDataModel: $0) }
                self.collectionView.reloadData()
            case .failure(let error):
                print("Ошибка загрузки из БД \(error)")
            }
        }
    }
    
    @objc func removePostFromFavorites(_ notification: NSNotification) {
        if let id = notification.userInfo?["id"] as? Int {
            self.contentPostData.removeAll(where: { $0.id == id } )
            self.collectionView.reloadData()
        }
     }
    
    @objc func addPostFromFavorites(_ notification: NSNotification) {
        if let post = notification.userInfo?["post"] as? FeedPost {
            self.contentPostData.append(post)
            self.collectionView.reloadData()
        }
     }
    
    private func removePostFromDatabase(_ post: FeedPost, using data:[FeedPost]) {
        let predicate = NSPredicate(format: "id == %ld", post.id)
        self.contentPostData.removeAll(where: { $0.id == Int(post.id) } )
        self.collectionView.reloadData()
        
        NotificationCenter.default.post(name: .didRemovePostFromFavorites, object: nil, userInfo: ["id" : post.id])
        
        self.dbCoordinator.delete(FavoriteFeedPost.self, predicate: predicate) { [weak self] result in

            guard let self = self else { return }
            
            switch result {
            case .success(let post):
                ()
            case .failure(let error):
                print("Ошибка удаления из бд \(error)")
            }
        }
    }
}

extension Favorite: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoritePostCollectionViewCell.identifire, for: indexPath) as? FavoritePostCollectionViewCell
        else {
            preconditionFailure("Произошло какое то говно при открытии вашего профиля")
            return UICollectionViewCell()
        }
        cell.setupPost(contentPostData[indexPath.item])
        cell.delegate = self
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        contentPostData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: (collectionView.frame.width - 40), height: (collectionView.frame.width - 40))
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //coordinator.showPost(contentPostData[indexPath.item])
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
