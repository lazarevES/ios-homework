//
//  AudioPlayer.swift
//  Navigation
//
//  Created by Егор Лазарев on 31.05.2022.
//

import Foundation
import UIKit
import AVFoundation

class AudioPlayer: UIViewController {
    
    let coordinator: AudioPlayerCordinator
    var player: AVAudioPlayer!
    var library: [(name: String, url: URL)] = []
    
    lazy var playButton: UIButton = {
        let button = UIButton()
        button.toAutoLayout()
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.setImage(UIImage(named: "musicPlay"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowOpacity = 0.7
        button.layer.shadowRadius = 4
        button.addTarget(self, action: #selector(startMusic), for: .touchUpInside)
        return button
    }()
        
    lazy var stopButton: UIButton = {
        let button = UIButton()
        button.toAutoLayout()
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.setImage(UIImage(named: "musicStop"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowOpacity = 0.7
        button.layer.shadowRadius = 4
        button.addTarget(self, action: #selector(stopMusic), for: .touchUpInside)
        return button
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.toAutoLayout()
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.setImage(UIImage(named: "musicBack"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowOpacity = 0.7
        button.layer.shadowRadius = 4
        button.addTarget(self, action: #selector(backMusic), for: .touchUpInside)
        return button
    }()
    
    lazy var nextbutton: UIButton = {
        let button = UIButton()
        button.toAutoLayout()
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.setImage(UIImage(named: "musicNext"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowOpacity = 0.7
        button.layer.shadowRadius = 4
        button.addTarget(self, action: #selector(nextMusic), for: .touchUpInside)
        return button
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.text = ""
        label.textAlignment = .natural
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    var counter = 0
    
    init(coordinator: AudioPlayerCordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view?.addSubviews(playButton, stopButton, nextbutton, backButton, nameLabel)
        useConstraint()
        
        fillLibrary()
        do {
            player = try AVAudioPlayer(contentsOf: library.first!.url)
            nameLabel.text = library.first!.name
            player.prepareToPlay()
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    private func useConstraint() {
        NSLayoutConstraint.activate([nameLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
                                     nameLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
                                     nameLabel.heightAnchor.constraint(equalToConstant: 70),
                                     backButton.topAnchor.constraint(equalTo: nameLabel.bottomAnchor,constant: Const.bigIndent),
                                     backButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Const.leadingMargin),
                                     backButton.heightAnchor.constraint(equalToConstant: 70),
                                     backButton.widthAnchor.constraint(equalToConstant: view.bounds.width / 5),
                                     playButton.topAnchor.constraint(equalTo: nameLabel.bottomAnchor,constant: Const.bigIndent),
                                     playButton.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: Const.leadingMargin),
                                     playButton.widthAnchor.constraint(equalToConstant: view.bounds.width / 5),
                                     playButton.heightAnchor.constraint(equalToConstant: 70),
                                     stopButton.topAnchor.constraint(equalTo: nameLabel.bottomAnchor,constant: Const.bigIndent),
                                     stopButton.leadingAnchor.constraint(equalTo: playButton.trailingAnchor, constant: Const.leadingMargin),
                                     stopButton.widthAnchor.constraint(equalToConstant: view.bounds.width / 5),
                                     stopButton.heightAnchor.constraint(equalToConstant: 70),
                                     nextbutton.topAnchor.constraint(equalTo: nameLabel.bottomAnchor,constant: Const.bigIndent),
                                     nextbutton.leadingAnchor.constraint(equalTo: stopButton.trailingAnchor, constant: Const.leadingMargin),
                                     nextbutton.widthAnchor.constraint(equalToConstant: view.bounds.width / 5),
                                     nextbutton.heightAnchor.constraint(equalToConstant: 70),
                                    ])
    }
    
    private func fillLibrary() {
        library.removeAll()
        library.append(("Радио тапок песня 1", URL(fileURLWithPath: Bundle.main.path(forResource: "Тапок 1", ofType: "mp3")!)))
        library.append(("Радио тапок песня 2", URL(fileURLWithPath: Bundle.main.path(forResource: "Тапок 2", ofType: "mp3")!)))
        library.append(("Радио тапок песня 3", URL(fileURLWithPath: Bundle.main.path(forResource: "Тапок 3", ofType: "mp3")!)))
        library.append(("Радио тапок песня 4", URL(fileURLWithPath: Bundle.main.path(forResource: "Тапок 4", ofType: "mp3")!)))
        library.append(("Радио тапок песня 5", URL(fileURLWithPath: Bundle.main.path(forResource: "Тапок 5", ofType: "mp3")!)))
    }
    
    @objc func startMusic() {
        
        if player.isPlaying {
            player.pause()
            playButton.setImage(UIImage(named: "musicPlay"), for: .normal)
        } else {
            player.play()
            playButton.setImage(UIImage(named: "musicPause"), for: .normal)
        }
    }
    
    
    @objc func stopMusic() {
        if player.isPlaying {
            player.stop()
            player.prepareToPlay()
            player.currentTime = TimeInterval(0)
            playButton.setImage(UIImage(named: "musicPlay"), for: .normal)
        }
    }
    
    @objc func backMusic() {
        do {
            if counter == 0 {
                counter = library.count - 1
            } else {
                counter -= 1
            }
            player = try AVAudioPlayer(contentsOf: library[counter].url)
            nameLabel.text = library[counter].name
            player.prepareToPlay()
            player.play()
            playButton.setImage(UIImage(named: "musicPause"), for: .normal)
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    @objc func nextMusic() {
        do {
            if counter == library.count - 1 {
                counter = 0
            } else {
                counter += 1
            }
            player = try AVAudioPlayer(contentsOf: library[counter].url)
            nameLabel.text = library[counter].name
            player.prepareToPlay()
            player.play()
            playButton.setImage(UIImage(named: "musicPause"), for: .normal)
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
}
