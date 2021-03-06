//
//  DetailView.swift
//  DeviceWallpaper
//
//  Created by Kensuke Hoshikawa on 2017/04/24.
//  Copyright © 2017年 star__hoshi. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

final class DetailView: WallpaperDrawUpView {
    let osLabel: GradientLabel = {
        let height = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height) / 2

        let label = GradientLabel(frame: CGRect(x: 0, y: 0, width: 0, height: height))
        label.font = UIFont(name: "HelveticaNeue-UltraLight", size: CGFloat(height * 0.7))
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.1

        return label
    }()

    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont(name: "AvenirNext-Medium", size: 45)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.1

        return label
    }()

    let releaseLevelLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont(name: "AvenirNext-Medium", size: 20)
        label.textAlignment = .center
        label.numberOfLines = 0

        return label
    }()

    let versionLevelLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont(name: "AvenirNext-Medium", size: 20)
        label.textAlignment = .center
        label.numberOfLines = 0

        return label
    }()

    let phoneLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont(name: "AvenirNext-Medium", size: 20)
        label.textAlignment = .center
        label.numberOfLines = 0

        return label
    }()

    let hardwareLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont(name: "AvenirNext-Medium", size: 20)
        label.textAlignment = .center
        label.numberOfLines = 0

        return label
    }()

    init(with deviceModel: DeviceModel, colorTheme: ColorTheme) {
        super.init(size: deviceModel.size, colorTheme: colorTheme)

        osLabel.colors = colorTheme.gradiation
        osLabel.text = deviceModel.systemVersion.fullName
        contentView.addSubview(osLabel)
        osLabel.snp.makeConstraints { make in
            switch deviceModel.type {
            case .iPad:
                make.top.equalTo(0)
            default:
                make.top.equalTo(30)
            }
            make.left.equalTo(8)
            make.right.equalTo(-8)
        }

        contentView.addSubview(nameLabel)
        nameLabel.text = deviceModel.modelName
        nameLabel.textColor = colorTheme.fontColor
        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(8)
            make.right.equalTo(-8)
            make.height.equalTo(75)
            make.top.equalTo(osLabel.snp.bottom).offset(2)
        }

        contentView.addSubview(hardwareLabel)
        hardwareLabel.text = "Model: " + deviceModel.hardware
        hardwareLabel.textColor = colorTheme.fontColor
        hardwareLabel.snp.makeConstraints { make in
            make.left.equalTo(8)
            make.right.equalTo(-8)
            make.height.equalTo(24)
            switch deviceModel.type {
            case .iPad:
                make.bottom.equalTo(-160)
            default:
                make.bottom.equalTo(-120)
            }
        }

        contentView.addSubview(phoneLabel)
        phoneLabel.text = "Name: " + deviceModel.phoneName
        phoneLabel.textColor = colorTheme.fontColor
        phoneLabel.snp.makeConstraints { make in
            make.left.equalTo(8)
            make.right.equalTo(-8)
            make.height.equalTo(24)
            make.bottom.equalTo(hardwareLabel.snp.top).offset(-16)
        }

        contentView.addSubview(releaseLevelLabel)
        releaseLevelLabel.text = "Release Level: " + deviceModel.releaseLevel
        releaseLevelLabel.textColor = colorTheme.fontColor
        releaseLevelLabel.snp.makeConstraints { make in
            make.left.equalTo(8)
            make.right.equalTo(-8)
            make.height.equalTo(24)
            make.bottom.equalTo(phoneLabel.snp.top).offset(-16)
        }

        contentView.addSubview(versionLevelLabel)
        versionLevelLabel.text = "Version Level: \n" + deviceModel.versionLevel
        versionLevelLabel.textColor = colorTheme.fontColor
        versionLevelLabel.snp.makeConstraints { make in
            make.left.equalTo(8)
            make.right.equalTo(-8)
            make.bottom.equalTo(releaseLevelLabel.snp.top).offset(-16)
        }
    }

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
