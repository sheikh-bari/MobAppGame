import UIKit
import QuartzCore
import SceneKit

final class GameViewController: UIViewController {

    var gameController: GameController = GameController()

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let scnView = self.view as? SCNView else {
            fatalError("view is not SCNView object")
        }

        let scene = SCNScene(named: "main.scn")!

        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        scene.rootNode.addChildNode(cameraNode)

        cameraNode.position = SCNVector3(x: 0, y: 10, z: 15)
        cameraNode.look(at: SCNVector3.init(0, 0, 0))

        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light!.type = .omni
        lightNode.position = SCNVector3(x: 0, y: 10, z: 1)
        scene.rootNode.addChildNode(lightNode)

        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light!.type = .ambient
        ambientLightNode.light!.color = UIColor.darkGray
        scene.rootNode.addChildNode(ambientLightNode)

        scnView.scene = scene
        gameController.addToNode(rootNode: scene.rootNode)

        scnView.showsStatistics = true

        scnView.backgroundColor = UIColor.black

        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeLeft(_:)))
        swipeLeft.direction = .left
        scnView.addGestureRecognizer(swipeLeft)

        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swipeRight(_:)))
        swipeRight.direction = .right
        scnView.addGestureRecognizer(swipeRight)

        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(swipeUp(_:)))
        swipeUp.direction = .up
        scnView.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(swipeDown(_:)))
        swipeDown.direction = .down
        scnView.addGestureRecognizer(swipeDown)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tapGesture.numberOfTapsRequired = 2
        scnView.addGestureRecognizer(tapGesture)
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        gameController.reset()
        gameController.startGame()
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    @objc func swipeLeft(_ sender: Any) {
        gameController.snake.turnLeft()
    }

    @objc func swipeRight(_ sender: Any) {
        gameController.snake.turnRight()
    }
    
    @objc func swipeUp(_ sender: Any) {
        gameController.snake.turnUp()
    }
    
    @objc func swipeDown(_ sender: Any) {
        gameController.snake.turnDown()
    }

    @objc func handleTap(_ gestureRecognize: UIGestureRecognizer) {
        
        gameController.reset()
        gameController.startGame()
    }
}
