//
//  Favorite.swift
//  Navigation
//
//  Created by Егор Лазарев on 26.07.2022.
//

import Foundation
import UIKit
import CoreData

class Favorite: UIViewController {
        
    var coordinator: FavoriteCoordinator
    var dbCoordinator: DatabaseCoordinatable
    var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>?
    
    lazy var postTable: UITableView = {
        let postTable = UITableView(frame: .zero, style: .plain)
        postTable.toAutoLayout()
		postTable.backgroundColor = UIColor.createColor(lightMode: .white, darkMode: .darkGray)
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
		button.setTitle("found".localized, for: .normal)
        button.titleLabel?.textColor = UIColor.createColor(lightMode: .white, darkMode: .black)
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
		button.setTitle("clear".localized, for: .normal)
        button.titleLabel?.textColor = UIColor.createColor(lightMode: .white, darkMode: .black)
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
        label.textColor = UIColor.createColor(lightMode: .black, darkMode: .white)
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
    }
    

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
		title = "favorites".localized
        
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
        
        let entityDescription = NSEntityDescription.entity(forEntityName: "FavoriteFeedPost", in: dbCoordinator.mainContext)

        let request = NSFetchRequest<NSFetchRequestResult>()
        request.entity = entityDescription
        
        let idSortDescriptor = NSSortDescriptor(key: "id", ascending: true)
        request.sortDescriptors = [idSortDescriptor]
    
        if searchIsEnable {
            let predicate = NSPredicate(format: "author == %@", searchName)
            request.predicate = predicate
        }
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request,
                                                              managedObjectContext: dbCoordinator.mainContext,
                                                              sectionNameKeyPath: nil,
                                                              cacheName: nil)
        fetchedResultsController?.delegate = self
        
        do {
            try fetchedResultsController?.performFetch()
        } catch {
            print(error)
        }
        
        postTable.reloadData()
                
    }
    
    @objc func SearchPost() {
		let alertController = UIAlertController(title: "foundAuthor".localized,
												message: "foundAuthorText".localized,
                                                preferredStyle: .alert)
        
        alertController.addTextField( configurationHandler: {(textField: UITextField!) in
            textField.placeholder = "Киря"
        })
        
		let action = UIAlertAction(title: "agree".localized,
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
        self.getPost()
        postTable.refreshControl?.endRefreshing()
    }
}

extension Favorite: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = postTable.dequeueReusableCell(withIdentifier: FavoritePostCollectionViewCell.identifire, for: indexPath) as? FavoritePostCollectionViewCell
        else {
            preconditionFailure("Произошло какое то говно при открытии вашего профиля")
        }
        let post = fetchedResultsController?.object(at: indexPath) as! FavoriteFeedPost
        cell.setupPost(FeedPost(postCoreDataModel: post))
        cell.delegate = self
		cell.backgroundColor = UIColor.createColor(lightMode: .white, darkMode: .darkGray)
        return cell
    
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
       
        let post = contentPostData[indexPath.row]
        
		let deleteAction = UIContextualAction(style: .destructive, title: "delete".localized) { (_ , _, completionHandler) in
            
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            guard let sections = fetchedResultsController?.sections else { return 0 }
            return sections[section].numberOfObjects
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

extension Favorite: NSFetchedResultsControllerDelegate {
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, sectionIndexTitleForSectionName sectionName: String) -> String? {
        return sectionName
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        postTable.beginUpdates()
    }
    
    func controller(controller: NSFetchedResultsController<NSFetchRequestResult>, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            postTable.insertSections(NSIndexSet(index: sectionIndex) as IndexSet, with: .fade)
        case .delete:
            postTable.deleteSections(NSIndexSet(index: sectionIndex) as IndexSet, with: .fade)
        case .update:
            postTable.reloadSections(NSIndexSet(index: sectionIndex) as IndexSet, with: .automatic)
        case .move:
            break
        @unknown default:
            fatalError()
        }
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any,
                    at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType,
                    newIndexPath: IndexPath?) {

        switch type {
        case .insert:
            if let indexPath = newIndexPath {
                postTable.insertRows(at: [indexPath as IndexPath], with: .automatic)
            }
        case .update:
            if let indexPath = indexPath {
                let favoriteFeedPost = fetchedResultsController?.object(at: indexPath as IndexPath) as! FavoriteFeedPost
                guard let cell = postTable.cellForRow(at: indexPath as IndexPath) as? FavoritePostCollectionViewCell else { break }
                cell.setupPost(FeedPost(postCoreDataModel: favoriteFeedPost))
                cell.delegate = self
            }
        case .move:
            if let indexPath = indexPath {
                postTable.deleteRows(at: [indexPath as IndexPath], with: .automatic)
            }
            if let newIndexPath = newIndexPath {
                postTable.insertRows(at: [newIndexPath as IndexPath], with: .automatic)
            }
        case .delete:
            if let indexPath = indexPath {
                postTable.deleteRows(at: [indexPath as IndexPath], with: .automatic)
            }
        @unknown default:
            fatalError("ХЗ что может произойти но сделаем обработчик")
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        postTable.endUpdates()
    }
}
