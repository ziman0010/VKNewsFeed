//
//  NewsfeedViewController.swift
//  VKNewsFeed
//
//  Created by Алексей Черанёв on 26.08.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol NewsfeedDisplayLogic: class {
  func displayData(viewModel: Newsfeed.Model.ViewModel.ViewModelData)
}

class NewsfeedViewController: UIViewController, NewsfeedDisplayLogic {

  var interactor: NewsfeedBusinessLogic?
  var router: (NSObjectProtocol & NewsfeedRoutingLogic)?

  // MARK: Object lifecycle
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  
  // MARK: Setup
  
  private func setup() {
    let viewController        = self
    let interactor            = NewsfeedInteractor()
    let presenter             = NewsfeedPresenter()
    let router                = NewsfeedRouter()
    viewController.interactor = interactor
    viewController.router     = router
    interactor.presenter      = presenter
    presenter.viewController  = viewController
    router.viewController     = viewController
  }
  
  // MARK: Routing
  

  
  // MARK: View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  func displayData(viewModel: Newsfeed.Model.ViewModel.ViewModelData) {

  }
  
}
