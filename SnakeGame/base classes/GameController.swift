import SceneKit

protocol GameControllerDelegate: class {
    func gameOver(sender: GameController)
}

final class GameController {
    private let sceneSize = 15
    private var timer: Timer!
    
    public var worldSceneNode: SCNNode?
    private var pointsNode: SCNNode?
    private var pointsText: SCNText?
    
    var snake: SnakeController = SnakeController()
    
    private var points: Int = 0
    private var mushroomPos: int2 = int2(0, 0)
    private var gameOver: Bool = false
    
    weak var delegate: GameControllerDelegate?
    
    init() {
        if let worldScene = SCNScene(named: "worldScene.scn") {
            worldSceneNode = worldScene.rootNode.childNode(withName: "worldScene", recursively: true)
            worldSceneNode?.removeFromParentNode()
            worldSceneNode?.addChildNode(snake)
            pointsNode = worldSceneNode?.childNode(withName: "pointsText", recursively: true)
            pointsNode?.pivot = SCNMatrix4MakeTranslation(5, 0, 0)
            pointsText = pointsNode?.geometry as? SCNText
        }
    }
    
    func reset() {
        gameOver = false
        points = 1
        snake.reset()
    }
    
    
    
    func startGame() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(updateSnake), userInfo: nil, repeats: true)
        //let rotateAction = SCNAction.rotate(by: CGFloat.pi * 2, around: SCNVector3(0, 1, 0), duration: 10.0)
        //pointsNode?.runAction(SCNAction.repeatForever(rotateAction))
    }
    
    @objc func updateSnake(timer: Timer) {

    }
    
    func addToNode(rootNode: SCNNode) {
        guard let worldScene = worldSceneNode else {
            return
        }
        worldScene.removeFromParentNode()
        rootNode.addChildNode(worldScene)
        worldScene.scale = SCNVector3(0.1, 0.1, 0.1)
    }

    private func updatePoints(points: String) {
        guard let pointsNode = pointsNode else {
            return
        }
        pointsText?.string = points
        let width = pointsNode.boundingBox.max.x - pointsNode.boundingBox.min.x
        pointsNode.pivot = SCNMatrix4MakeTranslation(width / 2, 0, 0)
        pointsNode.position.x = -width / 2
    }
    
}

