//
//  WallpaperListViewController.swift
//  DeviceWallpaper
//
//  Created by Kensuke Hoshikawa on 2017/04/11.
//  Copyright © 2017年 star__hoshi. All rights reserved.
//

import UIKit

final class WallpaperListViewController: UIViewController {
    let tableView = UITableView(frame: .zero, style: .plain)
    let presenter: WallpaperListPresentation
    var wallpapers: [WallpaperType] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    init(presenter: WallpaperListPresentation) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        presenter.viewDidLoad()
    }

    private func setUp() {
        navigationItem.title = "Menu"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Device Info", style: .plain, target: self, action: #selector(didTapDeviceInfoButton))
        if #available(iOS 9, *) {
            tableView.cellLayoutMarginsFollowReadableWidth = false
        }
        view = tableView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.description())
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let indexPathForSelectedRow = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPathForSelectedRow, animated: true)
        }
    }

    @objc private func didTapDeviceInfoButton(_ sender: Any?) {
        presenter.didTapDeviceInfo()
    }
}

extension WallpaperListViewController: WallpaperListView {
    func show(wallpapers: [WallpaperType]) {
        self.wallpapers = wallpapers
    }
}

extension WallpaperListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelect(wallpaper: wallpapers[indexPath.row])
    }
}

extension WallpaperListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wallpapers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.description())!
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = wallpapers[indexPath.row].title
        return cell
    }
}
