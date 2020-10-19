//
//  MainTabBarController.swift
//  Excite
//
//  Created by Haasith Sanka on 5/27/20.
//  Copyright © 2020 Haasith Sanka. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    var loginViewModel = LoginViewModel()
    var viewModel = UserViewModel()
    let actInd: UIActivityIndicatorView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        viewModel.user = loginViewModel.currentUser
        self.setUpTabs()
    }
    
    
    init(viewModel: LoginViewModel) {
       self.loginViewModel = viewModel
       super.init(nibName: nil, bundle: nil)
   }
       
   required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func setUpTabs() {
        let dateController = FindDateViewController()
        dateController.tabBarItem = UITabBarItem(title: "Find Date", image: UIImage(named: "search-orange"), tag: 0)

        let chatController = ChatViewController()
        chatController.tabBarItem = UITabBarItem(title: "Chat", image: UIImage(named: "chat-orange"), tag: 0)

        let profileController = ProfileViewController(viewModel: viewModel)
        profileController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "profile-white"), tag: 0)
        let tabBarList = [dateController, chatController, profileController]

        viewControllers = tabBarList
        
    }


}
