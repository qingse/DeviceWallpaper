//
//  WallpaperPresenter.swift
//  DeviceWallpaper
//
//  Created by Kensuke Hoshikawa on 2017/04/13.
//  Copyright © 2017年 star__hoshi. All rights reserved.
//

import Foundation

final class WallpaperPresenter: WallpaperPresentation {
    weak var view: WallpaperView?
    let interactor: WallpaperUseCase
    let router: WallpaperWireframe
    let wallpaper: WallpaperType

    init(interactor: WallpaperUseCase, router: WallpaperWireframe, wallpaper: WallpaperType) {
        self.interactor = interactor
        self.router = router
        self.wallpaper = wallpaper
    }

    func viewDidLoad() {
        interactor.retrieveDeviceModel()
    }

    func didTapActionButton() {
        router.presentActions { [weak self] _ in
            if let view = self?.view {
                self?.interactor.save(image: view.toUIImage())
            }
        }
    }
}

extension WallpaperPresenter: WallpaperInteractorOutput {
    func didRetrieve(_ deviceModel: DeviceModel) {
        switch wallpaper {
        case .simple(let theme):
            view?.showSimple(deviceModel: deviceModel, colorTheme: theme)
        case .normal(let theme):
            view?.showNormal(deviceModel: deviceModel, colorTheme: theme)
        case .detail(let theme):
            view?.showDetail(deviceModel: deviceModel, colorTheme: theme)
        }
    }

    func notAuthorizedPhotoLibrary() {
        router.presentAuthorizationDialog()

    }

    func didSaveImage() {
        router.presentSavedSuccessDialog()
    }

    func didSaveImageFail(with message: String) {
        router.presentSavedFailureDialog(with: message)
    }
}
