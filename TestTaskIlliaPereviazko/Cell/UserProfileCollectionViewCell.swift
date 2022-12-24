//
//  UserProfileCollectionViewCell.swift
//  TestTaskIlliaPereviazko
//
//  Created by Илья Петров on 03.11.2022.
//

import UIKit

final class UserProfileCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    static var height: CGFloat = 142
    
    // MARK: - IBOutlets
    @IBOutlet private var firstNameTextField: UITextField!
    @IBOutlet private var userNameTextField: UITextField!
    @IBOutlet private var lastNameTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(userName: String?, firstName: String?, lastName: String? ) {
        userNameTextField.text = userName
        firstNameTextField.text = firstName
        lastNameTextField.text = lastName
    }
    
    func getData() -> (userName: String?, lastName: String?, firstName: String?) {
        return (userNameTextField.text, lastNameTextField.text, firstNameTextField.text)
    }
}
