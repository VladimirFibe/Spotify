//
//  AppDelegate.swift
//  Spotify
//
//  Created by Vladimir Fibe on 06.07.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    
    let window = UIWindow(frame: UIScreen.main.bounds)
    window.rootViewController = UINavigationController(rootViewController: TitleViewController())
    window.backgroundColor = .spotifyBlack
    window.makeKeyAndVisible()
    self.window = window
    UINavigationBar.appearance().isTranslucent = false
    UINavigationBar.appearance().barTintColor = .spotifyBlack
    return true
  }
}

