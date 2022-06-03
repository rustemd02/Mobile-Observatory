//
//  LaunchesOverviewViewController.swift
//  Mobile-Observatory
//
//  Created by Рустем on 03.06.2022.
//

import UIKit

protocol LaunchesOverviewViewControllerInput: AnyObject {
    
}

protocol LaunchesOverviewViewControllerOutput {
    func getData(completion: @escaping () -> ())
    func numberOfRowsInSection(section: Int) -> Int
    func cellForRowAt (indexPath: IndexPath) -> Launch
    func getLaunchesData() -> [Launch]
    func resetData()
}

class LaunchesOverviewViewController: UIViewController, UIScrollViewDelegate {
    let api = NetworkService.shared
    private var output: LaunchesOverviewViewControllerOutput
    private var isFetching = false
    var launchesTableView = UITableView()
    
    
    init(output: LaunchesOverviewViewControllerOutput) {
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
        launchesTableView.refreshControl = UIRefreshControl()
        launchesTableView.refreshControl?.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
    }
  
    
    private func setupView() {
        title = "Запуски"
        view.backgroundColor = .white
        
        self.navigationItem.title = "Запуски"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        launchesTableView = UITableView(frame: view.bounds, style: .plain)
        //launchesTableView.delegate = self
        view.addSubview(launchesTableView)
        
        launchesTableView.register(LaunchTableViewCell.self, forCellReuseIdentifier: "LaunchTableViewCell")
        
        launchesTableView.snp.makeConstraints { maker in
            maker.top.equalTo(view.safeAreaLayoutGuide)
            maker.left.right.bottom.equalToSuperview()
        }
        
    }
    
    @objc private func didPullToRefresh() {
        output.resetData()
        loadData()
        launchesTableView.reloadData()
        self.launchesTableView.refreshControl?.endRefreshing()
    }
    
    private func loadData() {
        isFetching = true
        output.getData() { [weak self] in
            self?.launchesTableView.dataSource = self
            self?.launchesTableView.reloadData()
        }
        isFetching = false
    }
}


extension LaunchesOverviewViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return output.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let launch = output.cellForRowAt(indexPath: indexPath)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LaunchTableViewCell", for: indexPath) as? LaunchTableViewCell else {
            return UITableViewCell()
        }
        cell.launch = launch
        cell.configure()
        return cell
        
    }
}

extension LaunchesOverviewViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for index in indexPaths {
            if index.row >= (output.getLaunchesData().count - 3) && !isFetching {
                loadData()
                break
            }
        }
    }
}

//extension LaunchesOverviewViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        let launch = output.cellForRowAt(indexPath: indexPath)
//        let vc: CrewDetailViewController = CrewDetailModuleBuilder().build()
//        vc.crewMember = theCrewMember
//        navigationController?.pushViewController(vc, animated: true)
//    }
//}



