//
//  PasswordCollectionViewCell.swift
//  TestTaskIlliaPereviazko
//
//  Created by Илья Петров on 03.11.2022.
//

import UIKit

final class PasswordCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    static var height: CGFloat = 142
    
    // MARK: - IBOutlets
    @IBOutlet private var newPasswordTextFild: UITextField!
    @IBOutlet private var enterPasswordTextField: UITextField!
    @IBOutlet private var oldPassword: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func getData() -> (old: String?, new: String?, enter: String?) {
        return (oldPassword.text, newPasswordTextFild.text, enterPasswordTextField.text)
    }
}
