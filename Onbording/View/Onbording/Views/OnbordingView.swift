

import UIKit
import SnapKit

final class OnbordingView: BaseView {
    private let onbordingImageView = UIImageView()
    private let titleTextLable = UILabel()
    private let subtitleLable = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension OnbordingView {
    override func embedViews() {
        super.embedViews()
        [
            onbordingImageView,
            titleTextLable,
            subtitleLable
        ].forEach {
            self.addSubview($0)
        }
    }
    
    override func setupLayout() {
        super.setupLayout()
        onbordingImageView.snp.makeConstraints { make in
            make.height.equalTo(170)
            make.width.equalTo(170)
            make.top.equalTo(self.snp_topMargin).offset(50)
            make.centerX.equalTo(self.snp_centerXWithinMargins).offset(0)
        }
        
        titleTextLable.snp.makeConstraints { make in
            make.top.equalTo(onbordingImageView.snp_bottomMargin).offset(30)
            make.leading.equalTo(self.snp_leadingMargin).offset(16)
            make.trailing.equalTo(self.snp_trailingMargin).offset(-16)
        }
        
        subtitleLable.snp.makeConstraints { make in
            make.bottom.equalTo(self.snp_bottomMargin).offset(-20)
            make.leading.equalTo(self.snp_leadingMargin).offset(16)
            make.trailing.equalTo(self.snp_trailingMargin).offset(-16)
        }
    }
    
    override func setupAppearance() {
        super.setupAppearance()
        self.backgroundColor = .white
        onbordingImageView.contentMode = .scaleAspectFit
        
        titleTextLable.font = .systemFont(ofSize: 23, weight: .medium)
        titleTextLable.textColor = .black
        titleTextLable.numberOfLines = 3
        titleTextLable.textAlignment = .center
        
        subtitleLable.font = .systemFont(ofSize: 18, weight: .bold)
        subtitleLable.textColor = .lightGray
        subtitleLable.textAlignment = .center
        
    }
    
    func setupItems(index: Int) {
        onbordingImageView.image = R.Images.arrayImages[index]
        titleTextLable.text = R.Strings.arrayTitles[index]
        subtitleLable.text = R.Strings.arraySubtitles[index].uppercased()
    }
}
