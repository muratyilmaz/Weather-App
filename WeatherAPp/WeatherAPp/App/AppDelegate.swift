//
//  AppDelegate.swift
//  WeatherAPp
//
//  Created by Murat YILMAZ on 4.06.2018.
//  Copyright © 2018 Murat YILMAZ. All rights reserved.
//

import UIKit
import CoreData
import SVProgressHUD

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appRouter: AppRouter?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.clear)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        if let window = window {
            appRouter = AppRouter(window: window)
        }
        window?.makeKeyAndVisible()
        
        return true
    }

    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "WeatherAPp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}
