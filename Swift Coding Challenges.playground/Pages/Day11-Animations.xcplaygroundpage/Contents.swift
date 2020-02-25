import UIKit
import PlaygroundSupport

class ViewController: UIViewController {

    let topView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.yellow
        view.alpha = 0.5
        return view
    }()

    let bottomView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.purple
        return view
    }()

    override func viewDidLoad(){
        super.viewDidLoad()
        bottomView.frame = CGRect(x: self.view.frame.size.width/2-25, y: self.view.frame.size.height, width: 100, height: 100)
        self.view.addSubview(bottomView)

        topView.frame = CGRect(x: self.view.frame.size.width/2-25, y: -50, width: 100, height: 100)
        self.view.addSubview(topView)
        
        //MARK: Start Animations
        UIView.animate(withDuration: 1.0, delay: 0.2,
                       usingSpringWithDamping: 0.2, initialSpringVelocity: 0.0, options: [.repeat, .autoreverse], animations: {
                        
                        self.topView.center.y += 150
                        self.bottomView.center.y -= 400
        }, completion: nil)
        
//        UIView.animate(withDuration: 1.5, delay: 0.5, options: [.curveEaseOut], animations: {
//            self.bottomView.center.y -= 300
//            self.bottomView.backgroundColor = .blue
//            self.bottomView.transform = CGAffineTransform.init(scaleX: 0.8, y: 0.2)
//            self.topView.center.y += 300
//            self.topView.backgroundColor = .orange
//            self.topView.alpha = 1.0
//            self.topView.transform = CGAffineTransform(rotationAngle: 2.0)
//        }) { (success) in
//        }
    }
    
    func animateOneAtATime() {
        UIView.animate(withDuration: 1.5, delay: 0.5, options: [.curveEaseOut], animations: {
            self.bottomView.center.y -= 300
            self.bottomView.backgroundColor = .blue
            self.bottomView.transform = CGAffineTransform.init(scaleX: 0.8, y: 0.1)
        }) { (success) in
            UIView.animate(withDuration: 1.0, delay: 0.5, options: [.repeat,.autoreverse, .curveEaseInOut], animations: {
                self.topView.center.y += 300
                self.topView.backgroundColor = .orange
                self.topView.alpha = 1.0
                self.topView.transform = CGAffineTransform(rotationAngle: 2.0)
            },completion: nil)
        }
    }
}

let master = ViewController()
PlaygroundPage.current.liveView = master
