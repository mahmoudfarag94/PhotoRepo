//
//  PhotoListViewModel.swift
//  PhotosRepo
//
//  Created by Smart Zone on 5/12/22.
//

import Foundation

protocol PhotoAPIType {
    func getPhotosList(start: Int , limit: Int, completion: @escaping (_ list: [PhotoListResponseModel]? , _ error:Error?)->Void)
}

class PhotoListUseCase: PhotoAPIType{
    func getPhotosList(start: Int, limit: Int, completion: @escaping ([PhotoListResponseModel]? , Error?) -> Void) {
        let path =  "\(WebServices.photo.getEndPoint())?_start=\(start)&_limit=\(limit)"
        let req = BaseRequest(path: path)
        GenaricService.shared.genariceAPI(request: req) {(model: [PhotoListResponseModel]! , error, code) in
            if error !=  nil {
                completion(nil, error)
            }else{
                completion(model , nil)
            }
        }
    }
}
import RxSwift
import RxCocoa
import RxRelay

class PhotoListViewModel: BaseViewModel{

    var useCase: PhotoAPIType?
    let photos = BehaviorRelay<[PhotoListResponseModel]>(value: [])
    var loadMoreRelay = BehaviorRelay<Bool>(value: false)
    
    private var arr = [PhotoListResponseModel](){
        didSet{
            photos.accept(arr)
        }
    }
    private var start = 0
    private var limit = 10
    
    init(useCase: PhotoAPIType) {
        super.init()
        self.useCase = useCase
        getData()
    }
    
    func getData(){
        self.loadMoreRelay.accept(true)
        useCase?.getPhotosList(start: start, limit: limit) {[weak self] (model, error)  in
            if error != nil {
                print(error?.localizedDescription ?? "")
            }else{
                self?.arr.append(contentsOf: model ?? [])
                self?.start = (self?.getLastItemId())!
                self?.loadMoreRelay.accept(false)
            }
        }
    }
    
    func getLastItemId()->Int{
        return arr.last?.id ?? 0
    }
}
