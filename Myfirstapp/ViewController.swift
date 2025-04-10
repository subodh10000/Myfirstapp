import UIKit

class ViewController: UIViewController {

    let messageLabel: UILabel = {
        let label = UILabel()
        label.text = "Hello, CodePath"
        label.font = UIFont.systemFont(ofSize: 28, weight: .semibold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()

    let clickButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Click Me", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        addCodePathGradientBanner()
        setupUI()
    }

    func setupUI() {
        view.addSubview(messageLabel)
        view.addSubview(clickButton)

        NSLayoutConstraint.activate([
            messageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            messageLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 50),

            clickButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 20),
            clickButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

        clickButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        NSLayoutConstraint.activate([
            messageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            messageLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 50),

            clickButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 20),
            clickButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

    }

    @objc func buttonTapped() {
        messageLabel.text = "Yay 🎉"

        let randomColor = UIColor(hue: CGFloat.random(in: 0...1), saturation: 0.2, brightness: 1, alpha: 1)
        UIView.animate(withDuration: 0.5) {
            self.view.backgroundColor = randomColor
        }

        showConfetti()
    }



    func addCodePathGradientBanner() {
        let gradientView = UIView()
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(gradientView)

        NSLayoutConstraint.activate([
            gradientView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            gradientView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gradientView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            gradientView.heightAnchor.constraint(equalToConstant: 100)
        ])

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.systemIndigo.cgColor,
            UIColor.systemTeal.cgColor,
            UIColor.systemPurple.cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        gradientView.layer.insertSublayer(gradientLayer, at: 0)

        gradientView.layoutIfNeeded()
        gradientLayer.frame = gradientView.bounds

        // Label
        let bannerLabel = UILabel()
        bannerLabel.text = "CodePath THE GOAT org. 🎉"
        bannerLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        bannerLabel.textColor = .white
        bannerLabel.textAlignment = .center
        bannerLabel.translatesAutoresizingMaskIntoConstraints = false
        gradientView.addSubview(bannerLabel)

        NSLayoutConstraint.activate([
            bannerLabel.centerXAnchor.constraint(equalTo: gradientView.centerXAnchor),
            bannerLabel.centerYAnchor.constraint(equalTo: gradientView.centerYAnchor)
        ])
    }


    func showConfetti() {
        let confettiLayer = CAEmitterLayer()
        confettiLayer.emitterPosition = CGPoint(x: view.bounds.midX, y: -10)
        confettiLayer.emitterShape = .line
        confettiLayer.emitterSize = CGSize(width: view.bounds.width, height: 1)

        let colors: [UIColor] = [.systemRed, .systemBlue, .systemGreen, .systemYellow, .systemPink]

        let cells: [CAEmitterCell] = colors.map { color in
            let cell = CAEmitterCell()
            cell.birthRate = 6
            cell.lifetime = 6.0
            cell.velocity = 180
            cell.velocityRange = 50
            cell.emissionLongitude = .pi
            cell.spin = 3.5
            cell.spinRange = 1.0
            cell.scale = 0.08
            cell.scaleRange = 0.03
            cell.color = color.cgColor
            cell.contents = UIImage(systemName: "circle.fill")?.withTintColor(color, renderingMode: .alwaysOriginal).cgImage
            return cell
        }

        confettiLayer.emitterCells = cells
        view.layer.addSublayer(confettiLayer)

        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            confettiLayer.birthRate = 0
        }
    }
}
