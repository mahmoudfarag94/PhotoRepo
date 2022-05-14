//
//  PhotoTableViewCell.swift
//  PhotosRepo
//
//  Created by Smart Zone on 5/12/22.
//

import UIKit
import Kingfisher

class PhotoTableViewCell: UITableViewCell {

    static let identifire = "PhotoTableViewCell"
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var captionLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCellData(model: PhotoListResponseModel){
        photoImageView.kf.indicatorType = .activity
        guard let url = URL(string: model.url ?? "")else{return}
        photoImageView.kf.setImage(with: url)
        captionLbl.text = model.title ?? ""
    }
    
}
