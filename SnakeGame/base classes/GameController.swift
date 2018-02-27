import SceneKit

protocol GameControllerDelegate: class {
    func gameOver(sender: GameController)
}

final class GameController {
    private let sceneSize = 15
    private var timer: Timer!

    // MARK: - Properties Nodes
    public var worldSceneNode: SCNNode?
    private var pointsNode: SCNNode?
    private var pointsText: SCNText?


    weak var delegate: GameControllerDelegate?

    init() {
        if let worldScene = SCNScene(named: "worldScene.scn") {
            worldSceneNode = worldScene.rootNode.childNode(withName: "worldScene", recursively: true)
            worldSceneNode?.removeFromParentNode()
            pointsNode = worldSceneNode?.childNode(withName: "pointsText", recursively: true)
            pointsNode?.pivot = SCNMatrix4MakeTranslation(5, 0, 0)
            pointsText = pointsNode?.geometry as? SCNText
        }
        
    }

    // MARK: - Game Lifecycle
    func reset() {
        
    }

    func startGame() {
        
    }

    
}
