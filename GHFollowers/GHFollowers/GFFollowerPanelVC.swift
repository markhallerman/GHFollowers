//
//  GFFollowerPanelVC.swift
//  GHFollowers
//
//  Created by Mark on 8/22/21.
//
import Foundation

protocol GFFollowerItemVCDelegate: AnyObject {
    func didTapGetFollowers(for user: User)
}

class GFFollowerPanelVC: GFUserInfoPanelVC {

    weak var delegate: GFFollowerItemVCDelegate!


    init(user: User, delegate: GFFollowerItemVCDelegate) {
        super.init(user: user)

        self.delegate = delegate
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        configureItems()
    }


    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .followers, withCount: user.followers)
        itemInfoViewTwo.set(itemInfoType: .following, withCount: user.following)
        actionButton.set(backgroundColor: .systemGreen, title: "Git Followers")
    }


    override func actionButtonTapped() {
        delegate.didTapGetFollowers(for: user)
    }
}
