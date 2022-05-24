//
//  RocketsViewController.swift
//  Mobile-Observatory
//
//  Created by Рустем on 24.05.2022.
//
import UIKit

protocol RocketsViewControllerInput: AnyObject {
    
}

protocol RocketsViewControllerOutput {
    func getData(completion: @escaping () -> ())
    func numberOfRowsInSection(section: Int) -> Int
    func cellForRowAt (indexPath: IndexPath) -> Rocket
    func getRocketsData() -> [Rocket]
    func resetData()
}

class RocketsViewController: UIViewController, UIScrollViewDelegate {
    let api = NetworkService.shared
    private var output: RocketsViewControllerOutput
    private var isFetching = false
    var rocketsTableView = UITableView()
    
    
    init(output: RocketsViewControllerOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        loadData()
        rocketsTableView.refreshControl = UIRefreshControl()
        rocketsTableView.refreshControl?.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
    }
  
    
    private func setupView() {
        title = "Ракеты"
        view.backgroundColor = .white
        
        self.navigationItem.title = "Ракеты"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        rocketsTableView = UITableView(frame: view.bounds, style: .plain)
        rocketsTableView.delegate = self
        view.addSubview(rocketsTableView)
        
        rocketsTableView.register(RocketTableViewCell.self, forCellReuseIdentifier: "RocketTableViewCell")
        
        rocketsTableView.snp.makeConstraints { maker in
            maker.top.equalTo(view.safeAreaLayoutGuide)
            maker.left.right.bottom.equalToSuperview()
        }
        
    }
    
    @objc private func didPullToRefresh() {
        output.resetData()
        loadData()
        rocketsTableView.reloadData()
        self.rocketsTableView.refreshControl?.endRefreshing()
    }
    
    private func loadData() {
        isFetching = true
        output.getData() { [weak self] in
            self?.rocketsTableView.dataSource = self
            self?.rocketsTableView.reloadData()
        }
        isFetching = false
    }
}


extension RocketsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return output.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let rocket = output.cellForRowAt(indexPath: indexPath)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RocketTableViewCell", for: indexPath) as? RocketTableViewCell else {
            return UITableViewCell()
        }
        cell.rocket = rocket
        cell.configure()
        return cell
        
    }
}

extension RocketsViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for index in indexPaths {
            if index.row >= (output.getRocketsData().count - 3) && !isFetching {
                loadData()
                break
            }
        }
    }
}

extension RocketsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        let rocket = output.cellForRowAt(indexPath: indexPath)
//        let vc: RocketsViewController = RocketsModuleBuilder().build()
//        vc.rocket = rocket
//        navigationController?.pushViewController(vc, animated: true)
    }
}




