//
//  ViewController.swift
//  TestTaskIlliaPereviazko
//
//  Created by Илья Петров on 03.11.2022.
//

import UIKit

final class ViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet private var indicatorView: UIActivityIndicatorView!
    @IBOutlet private var collectionView: UICollectionView!
    private var profile: Profile?
    
    // MARK: - Properties
    
    enum Cells: Int, CaseIterable {
        case userDataProfile
        case saveChangesuserData
        case passwordData
        case saveChangesPassword
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib.init(nibName: "UserProfileCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "UserProfileCollectionViewCell")
        collectionView.register(UINib.init(nibName: "PasswordCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PasswordCollectionViewCell")
        collectionView.register(UINib.init(nibName: "SaveChangesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SaveChangesCollectionViewCell")
        indicatorView.startAnimating()
        loadingProfile()
    }
    
    private func loadingProfile() {
        let token = "hsdiftds6ts8vtsd8"
        Network.shared.getProfile(token: token) {[weak self] profile, string in
            guard let self = self else {return}
            
            DispatchQueue.main.async {
                self.indicatorView.stopAnimating()
                
                guard let profile = profile else {
                    let alert = UIAlertController(title: "Error", message: string, preferredStyle: .alert)
                    let ok = UIAlertAction(title: "Cancel", style: .cancel)
                    alert.addAction(ok)
                    self.present(alert, animated: true)
                    return
                }
                
                self.profile = profile
                self.collectionView.reloadData()
            }
        }
    }
    
    private func saveProvile(userName: String?, lastName: String?, firstName: String?) {
        indicatorView.startAnimating()
        Network.shared.editProfile(firstName: firstName, lastName: lastName) { [weak self] profile, string in
            guard let self = self else {return}
            
            DispatchQueue.main.async {
                self.indicatorView.stopAnimating()
                
                guard let profile = profile else {
                    self.alertAction(message: string)
                    return
                }
                
                self.profile = profile
                self.collectionView.reloadData()
                self.alertAction(message: string)
            }
        }
    }
    
    private func chancePassword(old: String, new: String, enter: String) {
        indicatorView.startAnimating()
        Network.shared.changePassword(oldPassword: old, newPassword: new, repeatPassword: enter) { [weak self] result, string in
            guard let self = self else {return}
            
            DispatchQueue.main.async {
                self.indicatorView.stopAnimating()
                self.alertAction(message: string)
            }
        }
    }
}

// MARK: CollectionView

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Cells.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cellType = Cells.init(rawValue: indexPath.row) else {
            fatalError()
        }
        
        switch cellType {
            
        case .userDataProfile:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserProfileCollectionViewCell", for: indexPath) as? UserProfileCollectionViewCell
            cell?.setup(userName: profile?.userName, firstName: profile?.firstName, lastName: profile?.lastName)
            
            return cell!
            
        case .saveChangesuserData:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SaveChangesCollectionViewCell", for: indexPath) as? SaveChangesCollectionViewCell
            cell?.onSave = { [weak self]  in
                guard let self = self else { return }
                if let cell = collectionView.cellForItem(at: IndexPath(item: 0, section: 0)) as?  UserProfileCollectionViewCell {
                    let value = cell.getData()
                    self.saveProvile(userName: value.userName, lastName: value.lastName, firstName: value.firstName)
                }
            }
            
            return cell!
            
        case .passwordData:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PasswordCollectionViewCell", for: indexPath) as? PasswordCollectionViewCell
            return cell!
            
        case .saveChangesPassword:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SaveChangesCollectionViewCell", for: indexPath) as? SaveChangesCollectionViewCell
            cell?.onSave  = { [weak self]  in
                guard let self = self else { return }
                if let cell = collectionView.cellForItem(at: IndexPath(item: 2, section: 0)) as?  PasswordCollectionViewCell {
                    let value = cell.getData()
                    guard let old = value.old, let new = value.new, let enter = value.enter else {
                        self.alertAction(message: "Enter the password correctly")
                        return
                        
                    }
                    self.chancePassword(old: old, new: new, enter: enter)
                }
            }
            return cell!
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let widht = collectionView.bounds.width
        guard let cellType = Cells.init(rawValue: indexPath.row) else {
            fatalError()
        }
        
        switch cellType {
        case .userDataProfile:
            return CGSize(width: widht, height: UserProfileCollectionViewCell.height)
        case .saveChangesuserData, .saveChangesPassword:
            return CGSize(width: widht, height: SaveChangesCollectionViewCell.height)
        case .passwordData:
            return CGSize(width: widht, height: PasswordCollectionViewCell.height)
        }
    }
}

extension ViewController {
    
    private func alertAction(message: String?) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
}
