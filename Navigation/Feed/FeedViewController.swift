//
//  FeedViewController.swift
//  Navigation
//
//  Created by Егор Лазарев on 08.02.2022.
//

import UIKit

class FeedViewController: UIViewController {
        
    var coordinator: FeedCoordinator
    var model: FeedModel
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
		collectionView.backgroundColor = UIColor.createColor(lightMode: .white, darkMode: .darkGray)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isUserInteractionEnabled = true
        return collectionView
    }()
    
    var contentPostData: [FeedPost] = []
    var favoritePostId = [Int]()
    
    init(coordinator: FeedCoordinator, model: FeedModel, dbCoordinator: DatabaseCoordinatable) {
        self.model = model
        self.coordinator = coordinator
        self.dbCoordinator = dbCoordinator
        super.init(nibName: nil, bundle: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(removePostFromFavorites(_:)),
                                               name: .didRemovePostFromFavorites,
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
        
		title = "feed".localized
            
        view.addSubview(collectionView)
        collectionView.register(PostCollectionViewCell.self, forCellWithReuseIdentifier: PostCollectionViewCell.identifire)
        contentPostData = model.getPost()
        useConstraint()
    }
    
        
    func useConstraint() {
        NSLayoutConstraint.activate([collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                                     collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                                     collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                                     collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)])
        
        getFavoritePost()
    }
    
    func getFavoritePost() {
        self.dbCoordinator.fetchAll(FavoriteFeedPost.self) { result in
            switch result {
            case .success(let FavoriteFeedPost):
                self.favoritePostId = FavoriteFeedPost.map{ Int($0.id) }
                self.collectionView.reloadData()
            case .failure(let error):
                print("Ошибка загрузки из БД \(error)")
            }
        }
    }
    
    private func savePostInDatabase(_ post: FeedPost, using data: [FeedPost]) {
        self.dbCoordinator.create(FavoriteFeedPost.self, keyedValues: [post.keyedValues]) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let post):
                self.favoritePostId.append(Int(post[0].id))
                NotificationCenter.default.post(name: .wasLikedPost, object: nil, userInfo: ["post" : FeedPost(postCoreDataModel: post[0])])
                self.collectionView.reloadData()
            case .failure(let error):
                print("Ошибка записи из бд \(error)")
            }
        }
    }
    
   @objc func removePostFromFavorites(_ notification: NSNotification) {
       if let id = notification.userInfo?["id"] as? Int {
           self.favoritePostId.removeAll(where: { $0 == id })
           self.collectionView.reloadData()
       }
    }
    
    private func removePostFromDatabase(_ post: FeedPost, using data: [FeedPost]) {
        let predicate = NSPredicate(format: "id == %ld", post.id)
        
        self.favoritePostId.removeAll(where: { $0 == post.id })
        self.collectionView.reloadData()
        
        NotificationCenter.default.post(name: .didRemovePostFromFavorites, object: nil, userInfo: ["id" : post.id])
       
        self.dbCoordinator.delete(FavoriteFeedPost.self, predicate: predicate) { result in
       
            switch result {
            case .success(_):
                print("Объект удален из бд")
            case .failure(let error):
                print("Ошибка удаления из бд \(error )")
            }
        }
    }
    
}

extension FeedViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostCollectionViewCell.identifire, for: indexPath) as? PostCollectionViewCell
        else {
            preconditionFailure("Произошло какое то говно при открытии вашего профиля")
        }
        cell.setupPost(contentPostData[indexPath.item], isFavorite: favoritePostId.contains(contentPostData[indexPath.item].id))
        cell.delegate = self
        return cell
    }
    
 
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        contentPostData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: Const.postSizeWidth, height: Const.postSizeHeight)
    }
    
}

extension FeedViewController: PostCollectionViewCellDelegate {
    func showPost(post: FeedPost) {
        self.coordinator.showPost(post)
    }
    
        
    func tapToPost(with post: FeedPost, isFavorite: Bool) {
        if isFavorite {
            self.removePostFromDatabase(post, using: [post])
        } else {
            self.savePostInDatabase(post, using: [post])
        }
    }
}
