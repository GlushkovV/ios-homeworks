//
//  ProfileView.swift
//  Navigation
//
//  Created by Vitaly Glushkov on 17.02.2022.
//

import UIKit

class ProfileView: UIView {

    @IBOutlet weak var profileViewLabelName: UILabel!
    @IBOutlet weak var profileViewLabelDataBirthday: UILabel!
    @IBOutlet weak var profileViewLabelCity: UILabel!
    @IBOutlet weak var profileViewLabelText: UITextView!
    @IBOutlet weak var profileViewLabelPhoto: UIImageView!
    
    override init(frame: CGRect) {
            super.init(frame: frame)
            self.setupView()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            self.setupView()
        }
        
        private func setupView() {
            let view = self.loadViewFromXib()
            view.frame = self.bounds // здесь view, загруженная из xib-файла, добавляется на вьюху класса. Ее размер соответствует размеру вьюхе класса и растягивается так же, как и сама вьюха класса.
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            self.addSubview(view)
            self.profileViewLabelName.text = "Виталий"
            self.profileViewLabelDataBirthday.text = "08.04.1986"
            self.profileViewLabelCity.text = "Самара"
            self.profileViewLabelText.text = "Через 15 лет работы в отрасли связи понял, что делать мобильную связь доступной хорошо, но создавать код лучше!"
        }
        
        private func loadViewFromXib() -> UIView {
            guard let view = Bundle.main.loadNibNamed("ProfileView", owner: self, options: nil)?.first as? UIView else { return UIView() }
            
            return view
        }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
