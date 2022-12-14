//
//  PatternLockViewController.swift
//  webView_swift
//
//  Created by wons on 2022/12/06.
//

import UIKit
import CCGestureLock

class PatternLockViewController: BaseViewController {

    let patternLockView = PatternLockView()
    let gestureLock = CCGestureLock()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupGestureLock()
    }
    
    override func setupLayout() {
        view.addSubview(patternLockView)
        view.addSubview(gestureLock)
    }
    
    override func setupConstraints() {
        patternLockView.translatesAutoresizingMaskIntoConstraints = false
        patternLockView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        patternLockView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 30).isActive = true
        patternLockView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -30).isActive = true
        patternLockView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        gestureLock.translatesAutoresizingMaskIntoConstraints = false
        gestureLock.topAnchor.constraint(equalTo: patternLockView.bottomAnchor, constant: 10).isActive = true
        gestureLock.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        gestureLock.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        gestureLock.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
//        gestureLock.backgroundColor = .white
    }
    
    @objc func gestureComplete(gestureLock: CCGestureLock) {
        let lockSequence = gestureLock.lockSequence
        
        var dataString = ""
        for seq in lockSequence {
            dataString.append("\(seq)")
        }
        print("패턴 번호 : \(dataString)")
        
        if dataString == "03678" {
            // 패턴 일치
            gestureLock.gestureLockState = .normal
            patternLockView.warningLabel.textColor = .green
            patternLockView.warningLabel.text = "성공~"
            
        } else {
            // 패턴 불일치
            gestureLock.gestureLockState = .error
            patternLockView.warningLabel.textColor = .systemRed
            
            if dataString.count < 4 {
                patternLockView.warningLabel.text = "4개 이상의 점을 연결해주세요"
            } else {
                patternLockView.warningLabel.text = "패턴이 일치하지 않습니다. 다시 그려주세요."
            }
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(0.5 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: {
                gestureLock.gestureLockState = .normal
            })
        }
    }
    
    func setupGestureLock() {
        // 가로, 세로 몇칸으로 만들지 (지금은 3x3 )
        // Set number of sensors
        gestureLock.lockSize = (numHorizontalSensors: 3, numVerticalSensors: 3)
        
        // 가장자리 간격 (숫자 늘리면 원들이 더 모여짐)
        // Sensor grid customisations
        gestureLock.edgeInsets = UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30)
         
        // 선택 안되어 있을 때 기본 안쪽 작은 원 색깔
        // Sensor point customisation (normal)
        gestureLock.setSensorAppearance(
            type: .inner,
            radius: 5,
            width: 1,
            color: .lightGray,
            forState: .normal
        )
        
        // 색 바꿔봐도 변하지 않음 .clear 디폴트
        gestureLock.setSensorAppearance(
            type: .outer,
            color: .clear,
            forState: .normal
        )
        
        // 그냥 선택할 때 안쪽 작은 원 색깔
        // Sensor point customisation (selected)
        gestureLock.setSensorAppearance(
            type: .inner,
            radius: 3,
            width: 5,
            color: .green,
            forState: .selected
        )
        
        // 그냥 선택 할 때 바깥쪽 큰 원 색깔
        gestureLock.setSensorAppearance(
            type: .outer,
            radius: 30,
            width: 5,
            color: .green,
            forState: .selected
        )
        
        // 에러 일 때 바뀌는 안쪽 작은 원 색깔
        // Sensor point customisation (wrong password)
        gestureLock.setSensorAppearance(
            type: .inner,
            radius: 3,
            width: 5,
            color: .red,
            forState: .error
        )
        
        // 에러 일 때 바뀌는 바깥쪽 큰 원 색깔
        gestureLock.setSensorAppearance(
            type: .outer,
            radius: 30,
            width: 5,
            color: .red,
            forState: .error
        )
        
        // 이어지는 선 색깔
        // Line connecting sensor points (normal/selected)
        [CCGestureLock.GestureLockState.normal, CCGestureLock.GestureLockState.selected].forEach { (state) in
             gestureLock.setLineAppearance(
                 width: 5.5,
                 color: UIColor.green.withAlphaComponent(0.5),
                 forState: state
             )
        }
         
        // 패턴 실패했을 때 바뀌는 선 색깔
        // Line connection sensor points (wrong password)
        gestureLock.setLineAppearance(
            width: 5.5,
            color: UIColor.red.withAlphaComponent(0.5),
            forState: .error
        )
        
        // 제스쳐 타겟 등록
        gestureLock.addTarget(
            self,
            action: #selector(gestureComplete),
            for: .gestureComplete
        )
    }
}
