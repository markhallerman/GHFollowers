import UIKit

class GFAvatarImageView: UIImageView {
    
    let placeholderImage = Images.avatarPlaceholder


    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }



    func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        image = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }

    
    func downloadImage(fromURL urlString: String) {
        NetworkManager.shared.downloadImage(fromURL: urlString) { [weak self] image in
           guard let self = self else { return }

            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
}
