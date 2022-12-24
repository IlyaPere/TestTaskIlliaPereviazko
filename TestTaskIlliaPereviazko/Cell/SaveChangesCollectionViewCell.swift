//
//  SaveChangesCollectionViewCell.swift
//  TestTaskIlliaPereviazko
//
//  Created by Илья Петров on 03.11.2022.
//

import UIKit

final class SaveChangesCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    var onSave: (() -> Void)?
    static var height: CGFloat = 70
    
    // MARK: - IBOutlets
    @IBOutlet private var saveButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        saveButton.layer.borderWidth = 1
        saveButton.layer.borderColor = UIColor.white.cgColor
        saveButton.layer.cornerRadius = 5
    }
    
    // MARK: - IBActions
    @IBAction private func saveButtonAction(_ sender: Any) {
        onSave?()
    }
}
