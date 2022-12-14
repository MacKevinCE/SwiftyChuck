//
//  ChuckDebugView.swift
//  SwiftyChuck
//
//  Created by Mc Kevin on 7/11/22.
//

import UIKit

class ChuckDebugView: NibDebugView {
    @IBOutlet private var backgroundButton: UIButton!
    @IBOutlet private var closeButton: UIButton!

    static let radius: CGFloat = 75
    static let closeImage: UIImage? = .close

    let radiusClose: CGFloat = 25
    let widthView: CGFloat = ChuckDebugView.radius
    let heightView: CGFloat = ChuckDebugView.radius

    var owner: UIViewController?
    var centerXConstraint: NSLayoutConstraint?
    var centerYConstraint: NSLayoutConstraint?

    var originDrag: CGPoint = .zero

    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundButton.layer.cornerRadius = ChuckDebugView.radius / 2
        closeButton.layer.cornerRadius = radiusClose / 2

        switch SwiftyChuck.iconCircle {
        case let .character(character, backgroundImage):
            if character.isASCII {
                backgroundButton.setImage(backgroundButton.getIcon(name: character), backgroundImage ?? backgroundButton.getIcon(name: "🟡"))
            } else {
                backgroundButton.setImage(backgroundButton.getIcon(name: character), backgroundImage)
            }
        case let .icon(image):
            backgroundButton.setBackgroundImage(image)
        }

        closeButton.setBackgroundImage(ChuckDebugView.closeImage)

        startOpacity()
    }

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let closePF = closeButton.frame
        let backgroundPF = backgroundButton.frame

        if closePF.contains(point) {
            return closeButton
        } else if backgroundPF.contains(point) {
            return backgroundButton
        }
        return nil
    }

    func addPopUp(owner: UIViewController) {
        self.owner = owner
        owner.view.addSubview(self)
        alpha = 0.95
        translatesAutoresizingMaskIntoConstraints = false

        centerXConstraint = centerXAnchor.constraint(equalTo: owner.view.centerXAnchor)
        centerYConstraint = centerYAnchor.constraint(equalTo: owner.view.centerYAnchor)

        centerXConstraint?.isActive = true
        centerYConstraint?.isActive = true

        let origin: CGPoint
        if SwiftyChuck.location == .zero {
            let widthMax = (owner.view.frame.width - widthView) / 2
            origin = CGPoint(x: -widthMax, y: 0)
        } else {
            origin = SwiftyChuck.location
        }

        newLocation(origin)

        widthAnchor.constraint(equalToConstant: widthView).isActive = true
        heightAnchor.constraint(equalToConstant: heightView).isActive = true
        owner.view.layoutIfNeeded()

        let gesture = UIPanGestureRecognizer(target: self, action: #selector(buttonDrag(pan:)))
        backgroundButton.addGestureRecognizer(gesture)
    }

    private func newPoint(_ originDrag: CGPoint, _ finalDrag: CGPoint, _ actualLocation: CGPoint) -> CGPoint {
        let pointX = actualLocation.x + (finalDrag.x - originDrag.x)
        let pointY = actualLocation.y + (finalDrag.y - originDrag.y)
        return CGPoint(x: pointX, y: pointY)
    }

    private func newLocation(_ point: CGPoint) {
        SwiftyChuck.location = point
        centerXConstraint?.constant = point.x
        centerYConstraint?.constant = point.y
    }

    private func currentLocation() -> CGPoint {
        let pointX = centerXConstraint?.constant ?? .zero
        let pointY = centerYConstraint?.constant ?? .zero
        return CGPoint(x: pointX, y: pointY)
    }

    private func animationView() {
        guard let owner = owner else { return }

        let current = currentLocation()

        let widthMax = (owner.view.frame.width - widthView) / 2
        let widthUltimo = widthMax * ((current.x > 0) ? 1 : -1)

        let heightMax = (owner.view.frame.height / 2) - heightView
        let heightUltimo = max(-heightMax, min(current.y, heightMax))

        let pointFinal = CGPoint(x: widthUltimo, y: heightUltimo)

        owner.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.1, delay: 0, options: [.curveEaseInOut], animations: { [weak self] in
            self?.newLocation(pointFinal)
            owner.view.layoutIfNeeded()
        }, completion: { [weak self] _ in
            self?.startOpacity()
        })
    }

    private func startOpacity() {
        afterOpacity(delay: 4, opacity: 0.25)
    }

    private func afterOpacity(delay: TimeInterval, opacity: Float) {
        UIView.animate(withDuration: delay, delay: delay, animations: { [weak self] in
            self?.view.layer.opacity = opacity
        }, completion: { _ in
        })
    }

    @objc
    func buttonDrag(pan: UIPanGestureRecognizer) {
        if pan.state == .began {
            originDrag = pan.location(in: backgroundButton)
        } else if pan.state == .ended {
            animationView()
        } else {
            let finalDrag = pan.location(in: backgroundButton)
            newLocation(newPoint(originDrag, finalDrag, currentLocation()))
        }
    }

    @IBAction func backgroundButtonTouchDown(_ sender: Any) {
        view.layer.opacity = 1
    }

    @IBAction private func backgroundButtonTouchUpInside(_ sender: Any) {
        SwiftyChuck.openChuckDebug()
        startOpacity()
    }

    @IBAction private func closeButtonTouchUpInside(_ sender: Any) {
        removeFromSuperview()
    }
}
