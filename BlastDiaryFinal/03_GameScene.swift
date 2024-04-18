import SpriteKit
import GameplayKit
import SwiftUI


class GameScene: SKScene, SKPhysicsContactDelegate{
    
    // moodText - @Binding과 동일

    
    // components
    let needle = SKSpriteNode(imageNamed: "needle2")
    let bubble = SKSpriteNode(imageNamed: "bubble")
    //let moodText = SKLabelNode(text: $moodText)
    
    // border5
    var bottomBorder = SKShapeNode()
    var topBorder = SKShapeNode()
    var leftBorder = SKShapeNode()
    var rightBorder = SKShapeNode()
    
    // touchCheck
    var startTouch = CGPoint()
    var endTouch = CGPoint()
    
    // SFX
    let soundFX = SKAction.playSoundFileNamed("bubblePop.wav", waitForCompletion: false)
    
    // Unity - start같은 개념인듯
    override func didMove(to view: SKView){
        
        //physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsWorld.contactDelegate = self
        
        bubble.size = .init(width: 1000, height: 1000)
        bubble.physicsBody = SKPhysicsBody(circleOfRadius: 500)
        bubble.physicsBody?.affectedByGravity = false
        bubble.physicsBody?.isDynamic = false
        bubble.position = .init(x: 0, y: 400)
        bubble.name = "bubble"
        
        
        
        
        addChild(bubble)
        
        needle.size = .init(width: 300, height: 300)
        needle.physicsBody = SKPhysicsBody(circleOfRadius: 120)
        //needle.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 120, height: 30))
        needle.physicsBody?.affectedByGravity = true
        needle.physicsBody?.isDynamic = true
        needle.position = .init(x: 0, y: -1000)
        needle.physicsBody?.contactTestBitMask = needle.physicsBody?.collisionBitMask ?? 0
        needle.name = "needle"
        //radian기준
        //needle.zRotation = .init(3.9)
        
        addChild(needle)
    
        bottomBorder.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: frame.width + 1000, height: 1))
        bottomBorder.physicsBody?.affectedByGravity = false
        bottomBorder.physicsBody?.isDynamic = false
        bottomBorder.position = .init(x: 0, y: -frame.height)
        addChild(bottomBorder)
        
        topBorder.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: frame.width + 1000, height: 1))
        topBorder.physicsBody?.affectedByGravity = false
        topBorder.physicsBody?.isDynamic = false
        topBorder.position = .init(x: 0, y: frame.height)
        addChild(topBorder)
        
        leftBorder.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 1, height: frame.height + 1000))
        leftBorder.physicsBody?.affectedByGravity = false
        leftBorder.physicsBody?.isDynamic = false
        leftBorder.position = .init(x: -frame.width/2, y: 0)
        addChild(leftBorder)
        
        rightBorder.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width:1, height: frame.height + 1000))
        rightBorder.physicsBody?.affectedByGravity = false
        rightBorder.physicsBody?.isDynamic = false
        rightBorder.position = .init(x: frame.width/2, y: 0)
        addChild(rightBorder)
        
        let camera = SKCameraNode()
        camera.setScale(2)
        addChild(camera)
        scene!.camera = camera
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        launch()
        
        // ***** multiTouch때문인듯
        for touch in touches{
            startTouch = touch.location(in: self)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            endTouch = touch.location(in: self)
        }
        
        //방향 바꿔야 함
        needle.physicsBody?.applyImpulse(CGVector(dx: (endTouch.x - startTouch.x)*2, dy: (endTouch.y - startTouch.y)*2) )
        
        //destroy(bubble: bubble)여긴 문제가 없군
    }
    
    //충돌 관련
    func collision(between needle: SKNode, object: SKNode){
        //object 가 부딪힌 물체?
        print("collision 호출")
        if object.name == "bubble"{
            
            destroy(bubble: bubble)
        }
    }
    
    func destroy(bubble: SKNode){

        print("destroy 호출")

        if let blastParticles = SKEmitterNode(fileNamed: "fireWork"){
            blastParticles.position = bubble.position
            addChild(blastParticles)
        }
        run(soundFX)
        bubble.removeFromParent()
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        print("contact 호출")
        guard let nodeA = contact.bodyA.node else {return}
        guard let nodeB = contact.bodyB.node else {return}
        
        if contact.bodyA.node?.name == "needle"{
            collision(between: contact.bodyA.node!, object: contact.bodyB.node!)
        }else if contact.bodyB.node?.name == "needle"{
            collision(between: contact.bodyB.node!, object: contact.bodyA.node!)
        }
    }
    
    func launch(){
        
    }
}
