//
//  ProfileViewController.swift
//  Navigation
//
//  Created by OksanaS on 16.03.2022.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    private lazy var tableView: UITableView = { //таблица
        let tableView = UITableView (frame: .zero)
        tableView.backgroundColor = .systemGray6
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: "PhotoCell")
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "PostCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 300
        return tableView
        
    }()
    
    private lazy var tableHeaderView: ProfileHeaderView = {
        let view = ProfileHeaderView(frame: .zero)
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var heightConstraint: NSLayoutConstraint? //хедера высота
    
    private lazy var jsonDecoder: JSONDecoder = {
        return JSONDecoder()
    }()
    
    private var dataSource: [News.Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchPosts { [weak self] posts in
            self?.dataSource = posts
            self?.tableView.reloadData()
        }
        self.tableView.tableHeaderView = tableHeaderView
        self.setupNavigationBar()
        self.setupView()
        setupProfileHeaderView()
    }
    
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationItem.title = "Profile"
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateHeaderViewHeight(for: tableView.tableHeaderView)
    }
    
    private func setupView() {
        // self.view.backgroundColor = .black
        self.view.addSubview(self.tableView)
        
        let topConstraint = self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor)
        let leadingConstraint = self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        let trailingConstraint = self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        let bottomConstraint = self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        
        NSLayoutConstraint.activate([
            topConstraint, leadingConstraint, trailingConstraint, bottomConstraint
        ])
    }
    
    
    
    private func setupProfileHeaderView() {
        self.view.backgroundColor = .lightGray
        
        let topConstraint = self.tableHeaderView.topAnchor.constraint(equalTo: tableView.topAnchor)
        let leadingConstraint = self.tableHeaderView.leadingAnchor.constraint(equalTo: tableView.leadingAnchor)
        let trailingConstraint = self.tableHeaderView.trailingAnchor.constraint(equalTo: tableView.trailingAnchor)
        self.heightConstraint = self.tableHeaderView.heightAnchor.constraint(equalToConstant: 220)
        let widthConstraint = self.tableHeaderView.widthAnchor.constraint(equalTo: tableView.widthAnchor)
        let bottomConstraint = self.tableHeaderView.bottomAnchor.constraint(equalTo: tableView.bottomAnchor)
        
        NSLayoutConstraint.activate([
            topConstraint, leadingConstraint, trailingConstraint, heightConstraint, widthConstraint, bottomConstraint
        ].compactMap( {$0} ))
        
    }
    
    func updateHeaderViewHeight(for header: UIView?) {//редактируем высоту хэдера
        guard let header = header else { return }
        header.frame.size.height = header.systemLayoutSizeFitting(CGSize(width: view.bounds.width, height: CGFloat(heightConstraint!.constant))).height
    }
    
    private func fetchPosts(complection: @escaping ([News.Post]) -> Void) {
        if let path = Bundle.main.path(forResource: "news", ofType: "json") { //используем json
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let news = try self.jsonDecoder.decode(News.self, from: data)
                print("json data: \(news)")
                complection(news.posts)
            } catch let error {
                print("parse error: \(error.localizedDescription)")
            }
        } else {
            fatalError("Invalid filename/path.")
        }
    }
}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    //Класс ProfileViewController должен реализовать протоколы UITableViewDelegate и UITableViewDataSource. Применить extension инструмент.
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as? PhotosTableViewCell else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
                return cell
            }
            cell.layer.shouldRasterize = true
            cell.layer.rasterizationScale = UIScreen.main.scale
            return cell
            
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as? PostTableViewCell else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
                return cell
            }
            cell.delegate = self
            let post = self.dataSource[indexPath.row - 1]
            let viewModel = PostTableViewCell.ViewModel(author: post.author, description: post.description,
                                                        image: post.image, likes: post.likes, views: post.views)
            cell.setup(with: viewModel)
            return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            let photoVC = PhotosViewController()
            self.navigationController?.pushViewController(photoVC, animated: true)
        }
    }
}

extension ProfileViewController: ProfileHeaderViewProtocol {
    func didTapStatusButton(textFieldIsVisible: Bool, completion: @escaping () -> Void) {
        self.heightConstraint?.constant = textFieldIsVisible ? 250 : 220
        
        tableView.beginUpdates()
        tableView.reloadSections(IndexSet(0..<1), with: .automatic)
        tableView.endUpdates()
        
        UIView.animate(withDuration: 0.3, delay: 0.0) {
            self.view.layoutIfNeeded()
        } completion: { _ in
            completion()
        }
    }
}

extension ProfileViewController: PostTableViewCellProtocol {
    
    func likePlus(cell: PostTableViewCell) {
        guard let index = self.tableView.indexPath(for: cell)?.row else { return }
        let indexPath = IndexPath(row: index, section: 0)
        self.dataSource[indexPath.row - 1].likes += 1
        self.tableView.reloadRows(at: [indexPath], with: .fade)
    }
    
    func postPlus(cell: PostTableViewCell) {
        let largePostView = PostView()
        guard let index = self.tableView.indexPath(for: cell)?.row else { return }
        let indexPath = IndexPath(row: index, section: 0)
        let post = self.dataSource[indexPath.row - 1]
        
        let viewModel = PostView.ViewModel(
            author: post.author, description: post.description, image: post.image, likes: post.likes, views: post.views)
        
        largePostView.setup(with: viewModel)
        self.view.addSubview(largePostView)
        
        largePostView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            largePostView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            largePostView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            largePostView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            largePostView.topAnchor.constraint(equalTo: view.topAnchor)
        ])
        
        self.dataSource[indexPath.row - 1].views += 1
        self.tableView.reloadRows(at: [indexPath], with: .fade)
        
    }
}
