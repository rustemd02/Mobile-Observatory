//
//  CrewViewController.swift
//  Mobile-Observatory
//
//  Created by Рустем on 23.05.2022.
//

import UIKit

protocol CrewViewControllerInput: AnyObject {
    
}

protocol CrewViewControllerOutput {
    func getData(completion: @escaping () -> ())
    func numberOfRowsInSection(section: Int) -> Int
    func cellForRowAt (indexPath: IndexPath) -> CrewMember
    func getCrewMemberData() -> [CrewMember]
    func resetData()
}

class CrewViewController: UIViewController, UIScrollViewDelegate {
    let api = NetworkService.shared
    private var output: CrewViewControllerOutput
    private var isFetching = false
    var crewTableView = UITableView()
    
    
    init(output: CrewViewControllerOutput) {
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
        crewTableView.refreshControl = UIRefreshControl()
        crewTableView.refreshControl?.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
    }
  
    
    private func setupView() {
        title = "Crew Dragon"
        view.backgroundColor = .white
        
        self.navigationItem.title = "Crew Dragon"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        crewTableView = UITableView(frame: view.bounds, style: .plain)
        crewTableView.delegate = self
        view.addSubview(crewTableView)
        
        crewTableView.register(CrewMemberTableViewCell.self, forCellReuseIdentifier: "CrewMemberTableViewCell")
        
        crewTableView.snp.makeConstraints { maker in
            maker.top.equalTo(view.safeAreaLayoutGuide)
            maker.left.right.bottom.equalToSuperview()
        }
        
    }
    
    @objc private func didPullToRefresh() {
        output.resetData()
        loadData()
        crewTableView.reloadData()
        self.crewTableView.refreshControl?.endRefreshing()
    }
    
    private func loadData() {
        isFetching = true
        output.getData() { [weak self] in
            self?.crewTableView.dataSource = self
            self?.crewTableView.reloadData()
        }
        isFetching = false
    }
}


extension CrewViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return output.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let theCrewMember = output.cellForRowAt(indexPath: indexPath)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CrewMemberTableViewCell", for: indexPath) as? CrewMemberTableViewCell else {
            return UITableViewCell()
        }
        cell.crewMember = theCrewMember
        cell.configure()
        return cell
        
    }
}

extension CrewViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for index in indexPaths {
            if index.row >= (output.getCrewMemberData().count - 3) && !isFetching {
                loadData()
                break
            }
        }
    }
}

extension CrewViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let theCrewMember = output.cellForRowAt(indexPath: indexPath)
        let vc: CrewDetailViewController = CrewDetailModuleBuilder().build()
        vc.crewMember = theCrewMember
        navigationController?.pushViewController(vc, animated: true)
    }
}



