//
//  ViewController.swift
//  lbta-count-animation
//
//  Created by Maxim Tsyganov on 26.04.2022.
//

import UIKit

class ViewController: UIViewController {

    private var displayLink: CADisplayLink?

    let countingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.text = "1234"
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()

        setupAnimation()
    }

    private func setupLayout() {
        view.backgroundColor = .red
        [countingLabel].forEach { view.addSubview($0) }

        NSLayoutConstraint.activate([
            countingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            countingLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            countingLabel.widthAnchor.constraint(equalTo: view.widthAnchor),
            countingLabel.heightAnchor.constraint(equalTo: countingLabel.widthAnchor)
        ])

    }

    private func setupAnimation() {
        displayLink = CADisplayLink(target: self, selector: #selector(handleUpdate))
        displayLink?.add(to: .main, forMode: .default)
    }

    var startValue: Double = 0
    let endValue: Double = 12000

    let animationStartDate = Date()
    let animationDuration = 1.5

    @objc func handleUpdate() {

        let now = Date()
        let elapsedTime = now.timeIntervalSince(animationStartDate)

        if elapsedTime > animationDuration {
            self.countingLabel.text = "\(endValue)"
            displayLink?.invalidate()
            displayLink = nil
        } else {
            let percentage = elapsedTime / animationDuration
            let value = startValue + percentage * (endValue - startValue)
            self.countingLabel.text = "\(value)"
        }

    }

}

