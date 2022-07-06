//
//  ViewController.swift
//  Spotify
//
//  Created by Vladimir Fibe on 06.07.2022.
//

import UIKit

class TitleViewController: UIViewController {
  var musicBarButtonItem: UIBarButtonItem!
  var podCastBarButtonItem: UIBarButtonItem!
  override func viewDidLoad() {
    super.viewDidLoad()
    setupNavBar()
  }
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nil, bundle: nil)
    musicBarButtonItem = makeBarButtonItem(text: "Music", selector: #selector(musicTapped))
    podCastBarButtonItem = makeBarButtonItem(text: "Podcasts", selector: #selector(podCastTapped))
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupNavBar() {
    navigationItem.leftBarButtonItems = [musicBarButtonItem, podCastBarButtonItem]
  }
  func makeBarButtonItem(text: String, selector: Selector) -> UIBarButtonItem {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.addTarget(self, action: selector, for: .primaryActionTriggered)
    let attributes = [ NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .largeTitle).withTraits(traits: [.traitBold]), NSAttributedString.Key.foregroundColor: UIColor.label]
    let attributedText = NSMutableAttributedString(string: text, attributes: attributes)
    button.setAttributedTitle(attributedText, for: .normal)
    button.contentEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 16)
    let barButtonItem = UIBarButtonItem(customView: button)
    return barButtonItem
  }
  
  @objc func musicTapped() {
    
  }
  
  @objc func podCastTapped() {
    
  }
}

class MusicViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Music"
    view.backgroundColor = .systemBlue
  }
}

class PodcastViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Podcast"
    view.backgroundColor = .systemYellow
  }
}

extension UIFont {
  func withTraits(traits: UIFontDescriptor.SymbolicTraits) -> UIFont {
    let descriptor = fontDescriptor.withSymbolicTraits(traits)
    return UIFont(descriptor: descriptor!, size: 0)
  }
  
  func bold() -> UIFont {
    withTraits(traits: .traitBold)
  }
}
