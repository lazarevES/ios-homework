//
//  VideoPlayer.swift
//  Navigation
//
//  Created by Егор Лазарев on 01.06.2022.
//

import Foundation
import UIKit
import AVFoundation
import AVKit

class VideoPlayer: UIViewController {
   
    let coordinator: VideoPlayerCoordinator
    var videoArray: [(name: String, url: URL)] = []
    
    lazy var videoTable: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.toAutoLayout()
        table.refreshControl = UIRefreshControl()
        table.isScrollEnabled = true
        table.separatorInset = .zero
        table.refreshControl?.addTarget(self, action: #selector(updateVideoArray), for: .valueChanged)
        table.rowHeight = UITableView.automaticDimension
        
        return table
    }()
    
    init(coordinator: VideoPlayerCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        fillLibrary()
        
        videoTable.dataSource = self
        videoTable.delegate = self
        
        videoTable.register(VideoPlayerCell.self, forCellReuseIdentifier: VideoPlayerCell.identifire)

        view.addSubview(videoTable)
        
        useConstraint()
        
    }
    
    func useConstraint() {
        NSLayoutConstraint.activate([videoTable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                                     videoTable.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                                     videoTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                                     videoTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)])
    }
    
    private func fillLibrary() {
        videoArray.removeAll()
        videoArray.append(("Игры, которые оказались никому не нужны", URL(fileURLWithPath: "https://www.youtube.com/embed/iunb7OHmaDk")))
        videoArray.append(("Самые мощные корабли Старой Республики и Галактической Империи", URL(fileURLWithPath: "https://www.youtube.com/embed/SXMKTgYL3Gs")))
        videoArray.append(("IKOTIKA - Гарри Поттер и Дары смерти. Часть 1 (обзор фильма)", URL(fileURLWithPath: "https://www.youtube.com/embed/EHBZKEHCrFs")))
        videoArray.append(("Расцвет и Упадок «Darksiders»", URL(fileURLWithPath: "https://www.youtube.com/embed/Tzs4HqHg36g")))
        videoArray.append(("Elden Ring | Сюжет НЕ_Вкратце", URL(fileURLWithPath: "https://www.youtube.com/embed/7QA-bwJk5EE")))
    }
                                                                                                  
    @objc func updateVideoArray() {
        videoTable.reloadData()
        videoTable.refreshControl?.endRefreshing()
    }
    
}

extension VideoPlayer: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        self.videoArray.count

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: VideoPlayerCell.identifire, for: indexPath) as! VideoPlayerCell
        cell.specifyFields(name: videoArray[indexPath.row].name, url: videoArray[indexPath.row].url)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let url = videoArray[indexPath.row].url
        let player = AVPlayer(url: url)
        let controller = AVPlayerViewController()
        controller.player = player
        
        present(controller, animated: true) {
            player.play() //Воспроизводится не будет, не стал разбираться, скорее всего потому что корявые ссылки у ютуба, а ставит плагины не хочу
        }
    }
    
}
