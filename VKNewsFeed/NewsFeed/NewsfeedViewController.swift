//
//  NewsfeedViewController.swift
//  VKNewsFeed
//
//  Created by Алексей Черанёв on 26.08.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol NewsfeedDisplayLogic: AnyObject {
    func displayData(viewModel: Newsfeed.Model.ViewModel.ViewModelData)
}

class NewsfeedViewController: UIViewController, NewsfeedDisplayLogic {
    
    var interactor: NewsfeedBusinessLogic?
    var router: (NSObjectProtocol & NewsfeedRoutingLogic)?
    private var feedViewModel = FeedViewModel.init(cells: [])
    
    @IBOutlet weak var table: UITableView!
    
    private var titleView = TitleView()
    private var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return refreshControl
    }()
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
        setup()
        setupTable()
        setupTopBars()
        
        view.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        interactor?.makeRequest(request: .getNewsFeed)
        interactor?.makeRequest(request: .getUser)
    }
    
    private func setupTable()
    {
        let topInset: CGFloat = 8
        table.contentInset.top = topInset
        table.register(UINib(nibName: "NewsfeedCell", bundle: nil), forCellReuseIdentifier: NewsfeedCell.reuseID)
        
        table.register(NewsfeedCodeCell.self, forCellReuseIdentifier: "NewsfeedCodeCell")
        
        table.separatorStyle = .none
        table.backgroundColor = .clear
        table.addSubview(refreshControl)
    }
    
    private func setupTopBars() {
        self.navigationController?.hidesBarsOnSwipe = false
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationItem.titleView = titleView
    }
    
    @objc private func refresh()
    {
        interactor?.makeRequest(request: .getNewsFeed)
    }
    func displayData(viewModel: Newsfeed.Model.ViewModel.ViewModelData) {
        
        switch viewModel {
        case .displayNewsfeed(feedViewModel: let feedViewModel):
            self.feedViewModel = feedViewModel
            table.reloadData()
            refreshControl.endRefreshing()
        case .displayUser(userViewModel: let userViewModel):
            titleView.set(userViewModel: userViewModel)
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView.contentOffset.y > scrollView.contentSize.height / 1.1
        {
            interactor?.makeRequest(request: .getNextBatch)
        }
    }
    
}
extension NewsfeedViewController: NewsfeedCodeCellDelegate {
    func revealPost(for cell: NewsfeedCodeCell) {
        guard let indexPath = table.indexPath(for: cell) else {
            return
        }
        let cellViewModel = feedViewModel.cells[indexPath.row]
        interactor?.makeRequest(request: .revealPost(postId: cellViewModel.postId))
    }
}

extension NewsfeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedViewModel.cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        let cell = tableView.dequeueReusableCell(withIdentifier: NewsfeedCell.reuseID, for: indexPath) as! NewsfeedCell
        let cellViewModel = feedViewModel.cells[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsfeedCodeCell") as! NewsfeedCodeCell
        
        cell.delegate = self
        cell.set(viewModel: cellViewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellViewModel = feedViewModel.cells[indexPath.row]
        return  cellViewModel.sizes.totalHeight
        //return 212
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellViewModel = feedViewModel.cells[indexPath.row]
        return  cellViewModel.sizes.totalHeight
    }
    
}
