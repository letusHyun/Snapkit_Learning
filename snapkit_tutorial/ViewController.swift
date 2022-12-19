//
//  ViewController.swift
//  snapkit_tutorial
//
//  Created by SeokHyun on 2022/12/19.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
  lazy var greenBox = { () -> UIView in
    let view = UIView()
    view.backgroundColor = .green
    return view
  }()
  
  lazy var redBox = { () -> UIView in
    let view = UIView()
    view.backgroundColor = .red
    return view
  }()
  
  lazy var yellowBox = { () -> UIView in
    let view = UIView()
    view.backgroundColor = .yellow
    return view
  }()
  
  lazy var blueBox = { () -> UIView in
    let view = UIView()
    view.backgroundColor = .blue
    return view
  }()
  
  lazy var myButton = { (color: UIColor) -> UIButton in
    let btn = UIButton(type: .system)
    btn.backgroundColor = color
    btn.setTitle("내 버튼", for: .normal)
    btn.titleLabel?.font = .boldSystemFont(ofSize: 40)
    btn.setTitleColor(.white, for: .normal)
    btn.layer.cornerRadius = 16
    return btn
  }
  
//  var greenBoxTopNSLayoutConstraint: NSLayoutConstraint? = nil
  
  //snapkit constraint 수정 변수
  var greenBoxConstraint: Constraint? = nil
  
 
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.addSubview(yellowBox)
    self.view.addSubview(redBox)
    self.view.addSubview(blueBox)
    self.view.addSubview(greenBox)
    let myDarkGrayBtn = myButton(.darkGray)
    self.view.addSubview(myDarkGrayBtn)

    myDarkGrayBtn.addTarget(self, action: #selector(moveGreenBoxDown), for: .touchUpInside)

    yellowBox.snp.makeConstraints { make in
      //edges: top, bottom, leading, trailing 4개 모두
      //inset은 bttom과 trailing을 음수로 주지 않아도 됨
//      make.edges.equalTo(self.view).inset(UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
      make.edges.equalToSuperview().inset(UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
    }
    
    redBox.snp.makeConstraints { make in
      make.height.width.equalTo(100)
      make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
      make.centerX.equalToSuperview()
//      make.center.equalToSuperview()
    }
    
    blueBox.snp.makeConstraints { make in
      make.width.equalTo(redBox.snp.width).multipliedBy(2)
      make.height.equalTo(redBox.snp.height)
      make.top.equalTo(redBox.snp.bottom).offset(20)
      make.centerX.equalToSuperview()
    }
    
    myDarkGrayBtn.snp.makeConstraints { make in
      make.width.equalTo(200)
      make.height.equalTo(100)
      make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
      make.centerX.equalToSuperview()
    }
    
    greenBox.snp.makeConstraints { make in
      make.width.height.equalTo(100)
      make.centerX.equalToSuperview()
//      make.centerX.equalTo(self.view)
      self.greenBoxConstraint =
      make.top.equalTo(blueBox.snp.bottom).offset(20).constraint
    }
    
//    greenBox.translatesAutoresizingMaskIntoConstraints = false
//    greenBoxTopNSLayoutConstraint = greenBox.topAnchor.constraint(equalTo: self.blueBox.bottomAnchor, constant: 20)
//    NSLayoutConstraint.activate([
//      greenBox.widthAnchor.constraint(equalToConstant: 100),
//      greenBox.heightAnchor.constraint(equalToConstant: 100),
//      greenBox.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
//    ])
//
//    greenBoxTopNSLayoutConstraint?.isActive = true
  }
  
  var offset = CGFloat(0)
  
  @objc fileprivate func moveGreenBoxDown() {
    
    print("ViewController - moveGreenBoxDown() called / offset: \(offset)")
    //    greenBoxTopNSLayoutConstraint?.constant = CGFloat(offset)
    
    if greenBox.frame.origin.y + greenBox.frame.height > yellowBox.bounds.height + 20 {
      //contant value만 업데이트 하고 싶은 경우
      greenBox.snp.updateConstraints { make in
        make.top.equalTo(self.blueBox.snp.bottom).offset(20)
        offset = 0
      }
    } else {
      offset += 40
      self.greenBoxConstraint?.update(offset: offset)
    }
  }
}


//SwiftUI 활용해서 Preview 생성
//opt + Cmd + enter: 미리보기 창 열기
//opt + Cmd + P: 실행
#if DEBUG
import SwiftUI
struct ViewControllerRepresentable: UIViewControllerRepresentable {
  func updateUIViewController(_ uiView: UIViewController, context: Context) {
    // leave this empty
  }
  @available(iOS 13.0.0, *)
  func makeUIViewController(context: Context) -> UIViewController {
    ViewController()
  }
}
@available(iOS 13.0.0, *)
struct SnapkitVCRepresentable_PreviewProvider: PreviewProvider {
  static var previews: some View {
    Group {
      ViewControllerRepresentable()
        .ignoresSafeArea()
        .previewDisplayName("Preview")
        .previewDevice(PreviewDevice(rawValue: "iPhone 14"))
    }
  }
} #endif
