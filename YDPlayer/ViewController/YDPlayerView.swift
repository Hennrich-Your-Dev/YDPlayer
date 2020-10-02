//
//  YDPlayerView.swift
//  YDPlayer
//
//  Created by Douglas Hennrich on 28/08/20.
//  Copyright © 2020 YourDev. All rights reserved.
//

import UIKit
import youtube_ios_player_helper
import WebKit

fileprivate let enterForeground = NSNotification.Name("foreground")

public class YDPlayerView: UIView {

	// MARK: Properties
	private var parent: UIView?
	private var config: YDPlayerConfiguration?
	private var player: YTPlayerView?
	private var enterFullScreen: Bool = false

	// MARK: IBOutlets
	@IBOutlet var contentView: UIView!

	// MARK: Life cycle
	deinit {
		NotificationCenter.default.removeObserver(self)
	}

	@discardableResult
	public init(with config: YDPlayerConfiguration, parent: UIView) {
		super.init(frame: CGRect(x: 0,
														 y: 0,
														 width: config.width,
														 height: config.height))
		commonInit()

		self.parent = parent
		self.config = config

		parent.addSubview(self)
		assignParentConstraints()
		configurePlayer()
	}

	required init?(coder: NSCoder) {
		fatalError("Don't implemented")
	}

	public override func layoutSubviews() {
		super.layoutSubviews()

		addObservers()
	}

	// MARK: Private actions
	private func commonInit() {
		contentView = loadNib()
		addSubview(contentView)
	}

	private func assignParentConstraints() {
		guard let parent = parent,
			let config = config
			else {
				fatalError("Don't have parent")
		}

		translatesAutoresizingMaskIntoConstraints = false
		let topAnchor = self.topAnchor.constraint(equalTo: parent.topAnchor)
		let trailingAnchor = self.rightAnchor.constraint(equalTo: parent.safeRightAnchor)
		let leadingAnchor = self.leftAnchor.constraint(equalTo: parent.safeLeftAnchor)
		let heightAnchor = self.heightAnchor.constraint(equalToConstant: config.height)
		parent.addConstraints([topAnchor, trailingAnchor, leadingAnchor, heightAnchor])

		assignContentViewConstraints()
	}

	private func assignContentViewConstraints() {
		contentView.translatesAutoresizingMaskIntoConstraints = false
		let topAnchor = contentView.topAnchor.constraint(equalTo: self.topAnchor)
		let bottomAnchor = contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
		let trailingAnchor = contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
		let leadingAnchor = contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor)

		addConstraints([topAnchor, trailingAnchor, leadingAnchor, bottomAnchor])
	}

	private func assignPlayerConstraints() {
		guard let player = player
			else {
				fatalError("Don't have player")
		}

		player.translatesAutoresizingMaskIntoConstraints = false
		let topAnchor = player.topAnchor.constraint(equalTo: self.topAnchor)
		let bottomAnchor = player.bottomAnchor.constraint(equalTo: self.bottomAnchor)
		let trailingAnchor = player.trailingAnchor.constraint(equalTo: self.trailingAnchor)
		let leadingAnchor = player.leadingAnchor.constraint(equalTo: self.leadingAnchor)

		addConstraints([topAnchor, trailingAnchor, leadingAnchor, bottomAnchor])
	}

	private func configurePlayer() {
		guard let config = config else {
			fatalError("Don't have config")
		}

		player = YTPlayerView()
		contentView.addSubview(player!)

		player?.delegate = self
		player?.load(withVideoId: config.videoId,
								 playerVars: [
									"playsinline": 1,
									"autoplay": 1,
									"controls": 1,
									"modestbranding": 0,
									"iv_load_policy": 2
		])

		assignPlayerConstraints()
	}

	// MARK: Observers
	private func addObservers() {
		NotificationCenter.default.addObserver(self,
																					 selector: #selector(playVideoAction),
																					 name: enterForeground,
																					 object: nil)

		NotificationCenter.default.addObserver(self,
																					 selector: #selector(enterFullScreenObserver),
																					 name: UIWindow.didResignKeyNotification,
																					 object: nil)

		NotificationCenter.default.addObserver(self,
																					 selector: #selector(exitFullScreen),
																					 name: UIWindow.didBecomeKeyNotification,
																					 object: nil)
	}

	@objc private func playVideoAction() {
		player?.playVideo()
	}

	@objc private func enterFullScreenObserver() {
		enterFullScreen = true
	}

	@objc private func exitFullScreen() {
		if enterFullScreen {
			player?.playVideo()
		}

		enterFullScreen = false
	}

}

extension YDPlayerView: YTPlayerViewDelegate {

	public func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
		playerView.playVideo()
	}

	public func playerView(_ playerView: YTPlayerView, didChangeTo state: YTPlayerState) {
		switch state {
		case .unstarted, .ended:
			break
		case .playing:
			print("playing")

		case .paused:
			print("paused")

		case .buffering:
			print("buffering")
			
		case .cued:
			print("cued")

		case .unknown:
			print("unknown")

		@unknown    default:
			break
		}
	}

}

