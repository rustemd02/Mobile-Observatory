//
//  AsteroidsViewController.swift
//  Mobile-Observatory
//
//  Created by andrewoch on 30.05.2022.
//

import Foundation
import UIKit

protocol AsteroidsInput {
    
}

protocol AsteroidsOutput {
    func viewDidLoad()
    func didSelectRow(at: Int)
    func numberOfRowsInSection(section: Int) -> Int
    func asteroidForRowAt (indexPath: IndexPath) -> NearEarthObject
    func getNearAsteroids(date: Date, completion: @escaping () -> ())
    func clearData()
}

class AsteroidsViewController: UIViewController, AsteroidsInput {
    
    private var output: AsteroidsOutput
    var asteroidsTableView = UITableView()
    
    private var titleLabel = UILabel()
    private var dateLabel = UILabel()
    private var datePicker = UIDatePicker()
    
    
    init(output: AsteroidsOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        asteroidsTableView.delegate = self
        setupView()
    }
    
    func setupView() {
        view.backgroundColor = .white
        view.addSubview(asteroidsTableView)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage(systemName: "calendar.circle"), style: .plain, target: self, action: #selector(changeDate))
        datePicker.datePickerMode = .date
        datePicker.date = Date()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.YYYY"
        let stringDate = dateFormatter.string(from: datePicker.date)
        navigationItem.title = "Астероиды " + stringDate
        
        asteroidsTableView.register(AsteroidTableViewCell.self, forCellReuseIdentifier: "AsteroidTableViewCell")
        asteroidsTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(12)
            make.left.right.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        reloadView()
    }
    
    @objc func changeDate() {
        let alert = UIAlertController(title: "Выберите дату", message: " ", preferredStyle: .alert)
        alert.view.addSubview(datePicker)
        datePicker.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(alert.view)
        }
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Применить", style: .default, handler: { _ in
            self.reloadView()
        }))
        present(alert, animated: true)
    }
    
    func reloadView() {
        output.clearData()
        asteroidsTableView.reloadData()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.YYYY"
        let stringDate = dateFormatter.string(from: datePicker.date)
        navigationItem.title = "Астероиды " + stringDate
        
        self.output.getNearAsteroids(date: self.datePicker.date) { [weak self] in
            self?.asteroidsTableView.dataSource = self
            self?.asteroidsTableView.reloadData()
        }
    }
}

extension AsteroidsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return output.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let asteroid = output.asteroidForRowAt(indexPath: indexPath)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AsteroidTableViewCell", for: indexPath) as? AsteroidTableViewCell else {
            return UITableViewCell()
        }
        cell.asteroid = asteroid
        cell.configure()
        return cell
    }
}

extension AsteroidsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = AsteroidDetailModuleBuilder().build()
        vc.asteroid = output.asteroidForRowAt(indexPath: indexPath)
        navigationController?.pushViewController(vc, animated: true)
    }
}
