//
//  InfoViewController.swift
//  Navigation
//
//  Created by Егор Лазарев on 08.02.2022.
//

import UIKit

class InfoViewController: UIViewController {
    
    var residents = [String]()
    var residentUrl: [String]?
    
    lazy var textLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.textAlignment = .center
        label.textColor = .white
        label.lineBreakMode = .byTruncatingMiddle
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        
        return label
    }()
    
    lazy var residentsTable: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.toAutoLayout()
        table.backgroundColor = .darkGray
        table.refreshControl = UIRefreshControl()
        table.isScrollEnabled = true
        table.separatorInset = .zero
        table.refreshControl?.addTarget(self, action: #selector(updateResidents), for: .valueChanged)
        table.rowHeight = UITableView.automaticDimension
        
        return table
    }()
    
    init(title: String, residentUrl: [String]? = nil) {
        super.init(nibName: nil, bundle: nil)
        textLabel.text = title
        self.residentUrl = residentUrl
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.toAutoLayout()
        view.backgroundColor = UIColor.darkGray
        
        residentsTable.dataSource = self
        residentsTable.delegate = self
        
        residentsTable.register(InfoTableCell.self, forCellReuseIdentifier: InfoTableCell.identifire)
        
        view.addSubviews(textLabel, residentsTable)
        useConstraint()
        
        if let residentUrl = residentUrl {
            residentUrl.forEach { url in
                NetworkService.URLSessionDataTask(postInfo: url, type: .resident) { title, people in
                    self.residents.append(title)
                    DispatchQueue.main.async {
                        self.residentsTable.reloadData()
                    }
                }
            }
        }
        
    }
    
    func useConstraint() {
        NSLayoutConstraint.activate([textLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Const.smallSize),
                                     textLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Const.smallSize),
                                     textLabel.heightAnchor.constraint(equalToConstant: 60),
                                     textLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Const.bigIndent),
                                     residentsTable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                                     residentsTable.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                                     residentsTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                                     residentsTable.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: Const.indent)])
    }
    
    @objc func updateResidents() {
        residentsTable.reloadData()
        residentsTable.refreshControl?.endRefreshing()
    }
        
}

extension InfoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        residents.count

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: InfoTableCell.identifire, for: indexPath) as! InfoTableCell
        cell.specifyFields(name: residents[indexPath.row])
        return cell
    }
    
}
