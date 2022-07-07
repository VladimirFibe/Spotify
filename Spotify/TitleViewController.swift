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
  let container = Container()
  let viewControllers: [UIViewController] = [MusicViewController(), PodcastViewController()]
  override func viewDidLoad() {
    super.viewDidLoad()
    setupNavBar()
    setupViews()
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
  func setupViews() {
    guard let containerView = container.view else { return }
    containerView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(containerView)
    NSLayoutConstraint.activate([
      containerView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 2),
      containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
      
    ])
    musicTapped()
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
    if container.children.first == viewControllers[0] { return }
    container.add(viewControllers[0])
    animateTransition(from: viewControllers[1], to: viewControllers[0]) { success in
      self.viewControllers[1].remove()
    }
    UIView.animate(withDuration: 0.5) {
      self.musicBarButtonItem.customView?.alpha = 1.0
      self.podCastBarButtonItem.customView?.alpha = 0.5
    }
  }
  
  @objc func podCastTapped() {
    if container.children.first == viewControllers[1] { return }
    container.add(viewControllers[1])
    animateTransition(from: viewControllers[0], to: viewControllers[1]) { success in
      self.viewControllers[0].remove()
    }
    UIView.animate(withDuration: 0.5) {
      self.musicBarButtonItem.customView?.alpha = 0.5
      self.podCastBarButtonItem.customView?.alpha = 1
    }
  }
  
  func animateTransition(from: UIViewController, to: UIViewController, completion: @escaping ((Bool) -> Void)) {
    guard let fromView = from.view,
          let fromIndex = getIndex(forViewController: from),
          let toView = to.view,
          let toIndex = getIndex(forViewController: to) else { return }
    let frame = from.view.frame
    var fromFramedEnd = frame
    var toFramedStart = frame
    fromFramedEnd.origin.x = toIndex > fromIndex ? frame.origin.x - frame.width : frame.origin.x + frame.width
    toFramedStart.origin.x = toIndex > fromIndex ? frame.origin.x + frame.width : frame.origin.x - frame.width
    toView.frame = toFramedStart
    UIView.animate(withDuration: 0.5) {
      fromView.frame = fromFramedEnd
      toView.frame = frame
    } completion: { success in
      completion(success)
    }

  }
  
  func getIndex(forViewController vc: UIViewController) -> Int? {
    for (index, thisVC) in viewControllers.enumerated() {
      if thisVC == vc { return index}
    }
    return nil
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

extension UIViewController {
  func add(_ child: UIViewController) {
    addChild(child)
    view.addSubview(child.view)
    child.didMove(toParent: self)
  }
  
  func remove() {
    guard parent != nil else { return }
    willMove(toParent: nil)
    view.removeFromSuperview()
    removeFromParent()
  }
}

extension UIColor {
  static let spotifyGreen = UIColor(red: 30 / 255, green: 215 / 255, blue: 96 / 255, alpha: 1.0)
  static let spotifyBlack = UIColor(red: 12 / 255, green: 12 / 255, blue: 12 / 255, alpha: 1.0)
}
