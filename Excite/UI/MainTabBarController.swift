//
//  MainTabBarController.swift
//  Excite
//
//  Created by Haasith Sanka on 5/27/20.
//  Copyright © 2020 Haasith Sanka. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //tabBar.barTintColor = UIColor(red: 38/255, green: 196/255, blue: 133/255, alpha: 1)
        setUpTabs()
    }
    func setUpTabs() {
        let dateController = FindDateViewController()
        dateController.tabBarItem = UITabBarItem(title: "Find Date", image: UIImage(named: "search-orange"), tag: 0)

        let chatController = ChatViewController()
        chatController.tabBarItem = UITabBarItem(title: "Chat", image: UIImage(named: "chat-orange"), tag: 0)

        let profileController = ProfileViewController()
        profileController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "profile-white"), tag: 0)
        let tabBarList = [dateController, chatController, profileController]

        viewControllers = tabBarList
        
        NetworkRequesterMock().getFood(name: "test")
        NetworkRequesterMock().getUser(id: "test")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
