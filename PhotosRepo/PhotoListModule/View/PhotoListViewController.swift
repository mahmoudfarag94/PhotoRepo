//
//  PhotoListViewController.swift
//  PhotosRepo
//
//  Created by Smart Zone on 5/12/22.
//

import UIKit
import RxCocoa
import RxSwift
import ImageSlideshow
import Kingfisher

class PhotoListViewController: BaseViewController<PhotoListViewModel> {

    @IBOutlet weak var photoListTblView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        bindViewModel()
        bintToTableView()
    }
    
    func setupTableView(){
        photoListTblView.estimatedRowHeight = 152
        photoListTblView.rowHeight = UITableView.automaticDimension
        photoListTblView.delegate = nil
        photoListTblView.dataSource = nil
        photoListTblView.registerCell(type: PhotoTableViewCell.self)
    }
    
    override func bindViewModel(){
        viewModel = PhotoListViewModel(useCase: PhotoListUseCase())
        guard let viewModel = viewModel else {return}
        viewModel.photos
            .bind(to: photoListTblView.rx.items(cellIdentifier: PhotoTableViewCell.identifire, cellType: PhotoTableViewCell.self)) { (row, photo, cell) in
                cell.setCellData(model: photo)
        }.disposed(by: disposeBag)
    }
    
    func bintToTableView(){
        photoListTblView.rx.modelSelected(PhotoListResponseModel.self).subscribe(onNext: {(model) in
            let sliderVC = FullScreenSlideshowViewController()
            let slider = ImageSlideshow()
            slider.activityIndicator = DefaultActivityIndicator()
            guard let kingfisherSource = KingfisherSource(urlString: model.thumbnailUrl ?? "") else{return}
            slider.setImageInputs([kingfisherSource])
            sliderVC.slideshow = slider
            self.present(sliderVC, animated: true, completion: nil)
        }).disposed(by: disposeBag)
        photoListTblView.rx.didScroll.subscribe(onNext: {[weak self] in
            let offsetY = self?.photoListTblView.contentOffset.y
            let height = self?.photoListTblView.contentSize.height
            let frame = self?.photoListTblView.frame.size.height
            let final = height! - frame! - 152
            if offsetY! > final{
                if self?.viewModel?.loadMoreRelay.value == false{
                    self?.viewModel?.getData()
                }
            }else{
                print("test")
            }
        }).disposed(by: disposeBag)
    }
}
