//
//  CardiLink_2_0App.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 04.03.21.
//

import SwiftUI

@main
struct CardiLink_2_0App: App {

    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var navigationManager = NavigationManager()
    @AppStorage("appearanceMode") private var storedAppearanceMode: String = AppearanceMode.system.rawValue

    let defaults = UserDefaults.standard
    func sceneDidDisconnect(_ scene: UIScene) {
        print("App is dead")
        defaults.set("", forKey: "myPortal")
        defaults.set("NO", forKey: "callServiceTickets")
        defaults.set("", forKey: "Backend")
        defaults.set("", forKey: "BackendAdd")
        defaults.set("", forKey: "SelectedDefi")
        defaults.set("NO", forKey: "selftestload")
        defaults.set("NO", forKey: "messageload")
        defaults.set("0", forKey: "ActiveNotification")
        defaults.set("No", forKey: "Moving")
        defaults.set("NO", forKey: "MovingLoadingDone")
        defaults.set("NO", forKey: "WaitForItOverview")
        clearAllFile()
    }

    init() {
        applyTheme(AppearanceMode(rawValue: storedAppearanceMode)!)
        }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(navigationManager)
        }
    }

    func applyTheme(_ mode: AppearanceMode) {
        switch mode {
        case .dark:
            (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first!.overrideUserInterfaceStyle = .dark
        case .light:
            (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first!.overrideUserInterfaceStyle = .light
        case .system:
            (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first!.overrideUserInterfaceStyle = .unspecified
        }
    }
    
}

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        let contentView = ContentView()

        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}

