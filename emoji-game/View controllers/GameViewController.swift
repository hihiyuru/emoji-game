import UIKit

class GameViewController: UIViewController {
    
    // 遊戲問題數據
    var gameDatas: [Question] = [
        Question(topic: ["🐯", "🐯", "🐯", "🐯"], ans: ["虎", "頭", "虎", "腦"]),
        Question(topic: ["👣", "📈", "💨", "🤷‍♂️"], ans: ["趾", "高", "氣", "揚"]),
        Question(topic: ["😈", "💬", "💔", "👤"], ans: ["惡", "語", "傷", "人"]),
        Question(topic: ["1️⃣", "🎵", "🤯", "👤"], ans: ["一", "鳴", "驚", "人"]),
        Question(topic: ["⏰", "🛶", "🔍", "⚔️"], ans: ["刻", "舟", "求", "劍"]),
        Question(topic: ["🦏", "🦏", "🌕", "👀"], ans: ["犀", "牛", "望", "月"]),
        Question(topic: ["1️⃣", "👁️", "💘", "💘"], ans: ["一", "見", "鍾", "情"]),
        Question(topic: ["❤️", "👄", "❌", "1️⃣"], ans: ["心", "口", "不", "一"]),
        Question(topic: ["🐉", "🚫", "👑", "👤"], ans: ["羣", "龍", "無", "首"]),
        Question(topic: ["🚗", "🌊", "🐎", "🐉"], ans: ["車", "水", "馬", "龍"]),
        Question(topic: ["🐔", "👙", "🐢", "🐢"], ans: ["雞", "胸", "龜", "背"]),
        Question(topic: ["🎉", "☀️", "😄", "🌍"], ans: ["歡", "天", "喜", "地"]),
        Question(topic: ["🔭", "👀", "🍂", "🌊"], ans: ["望", "穿", "秋", "水"]),
        Question(topic: ["👨‍🎓", "🔄", "🐎", "🔄"], ans: ["人", "仰", "馬", "翻"]),
        Question(topic: ["🙉", "🔒", "🛎️", "🔒"], ans: ["掩", "耳", "盜", "鈴"]),
        Question(topic: ["🐎", "🚶‍♂️", "🌺", "👀"], ans: ["走", "馬", "觀", "花"]),
        Question(topic: ["🐔", "🌅", "🔔", "⏰"], ans: ["雞", "鳴", "而", "起"]),
        Question(topic: ["🏹", "❤️", "➡️", "🏡"], ans: ["歸", "心", "似", "箭"]),
        Question(topic: ["🐔", "🐕", "🌌", "✨"], ans: ["雞", "犬", "升", "天"]),
        Question(topic: ["🤝", "➕", "🤝", "➕"], ans: ["攜", "手", "並", "肩"]),
    ]
    
    // 紀錄玩家已點擊答案的次數
    var clickAnsCount = 0
    
    // 紀錄玩家已選擇的答案
    var selectedWords: [String] = []
    
    // 當前遊戲關卡數據
    var levelData: Question?
    
    // 按鈕的初始位置
    var originalButtonPosition: [CGPoint] = []
    
    // 紀錄玩家獲勝次數，屬性觀察器會自動更新界面
    var winAcount = 0 {
        didSet {
            winAcountLabel.text = String(winAcount)
        }
    }
    
    // 判斷遊戲是否結束的計算屬性
    var isGameOver: Bool {
        return heartsImageView.isEmpty
    }
    
    @IBOutlet weak var winAcountLabel: UILabel!
    @IBOutlet var heartsImageView: [UIImageView]!
    @IBOutlet var topicLabel: [UILabel]!
    @IBOutlet var wordsButton: [UIButton]!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var gameOverView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setOriginalButtonPosition()
    }
    
    // 設定按鈕的初始位置
    func setOriginalButtonPosition() {
        for word in wordsButton {
            originalButtonPosition.append(word.frame.origin)
        }
    }
    
    // 初始化界面和遊戲數據
    func setUI() {
        setBackground()
        gameOverView.isHidden = true
        titleView.layer.cornerRadius = 5
        gameDatas.shuffle()
        updateLevel()
    }
    
    // 設定背景漸變效果
    func setBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [
            CGColor(red: 41/255, green: 61/255, blue: 133/255, alpha: 1),
            CGColor(red: 63/255, green: 144/255, blue: 82/255, alpha: 1)
        ]
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    // 更新遊戲關卡
    func updateLevel() {
        if !gameDatas.isEmpty {
            levelData = gameDatas.removeFirst()
            if let question = levelData {
                // 更新題目標籤
                for (index, label) in topicLabel.enumerated() {
                    if index < question.topic.count {
                        label.text = question.topic[index]
                    }
                }
                // 更新按鈕文字
                for (index, button) in wordsButton.enumerated() {
                    if index < question.others.count {
                        button.setTitle(question.others[index], for: .normal)
                    }
                }
            }
        } else {
            gameOverView.isHidden = false
        }
        
    }
    
    // 初始化界面元素
    func initUI() {
        for (index, word) in wordsButton.enumerated() {
            UIView.animate(withDuration: 0.5) {
                word.frame.origin = self.originalButtonPosition[index]
                word.isEnabled = true
                
            }
            selectedWords.removeAll()
            clickAnsCount = 0
        }
    }
    
    // 按鈕點擊事件
    @IBAction func clickWord(_ sender: UIButton) {
        guard clickAnsCount != 4 else {
            return
        }
        
        let delayInSeconds: Double = 1.0 // 延遲 1 秒
        let targetY: CGFloat = 425
        var targetX: CGFloat
        
        clickAnsCount += 1
        switch clickAnsCount {
        case 1:
            targetX = 94
            
        case 2:
            targetX = 155
            
        case 3:
            targetX = 215
            
        case 4:
            targetX = 276
            
        default:
            targetX = 94
        }
        
        // 移動按鈕位置並禁用
        UIView.animate(withDuration: 0.5) {
            sender.frame.origin = CGPoint(x: targetX, y: targetY)
            sender.isEnabled = false
            sender.backgroundColor = .white
            sender.layer.cornerRadius = 5
            sender.setTitleColor(.darkGray, for: .disabled)
        }
        
        selectedWords.append(sender.titleLabel?.text ?? "")
        if selectedWords.count == 4 {
            for (index, word) in selectedWords.enumerated() {
                if word != levelData?.ans[index] {
                    heartsImageView[heartsImageView.count - 1].isHidden = true
                    heartsImageView.removeLast()
                    
                    // 延遲一段時間後執行的程式碼
                    DispatchQueue.main.asyncAfter(deadline: .now() + delayInSeconds) { [self] in
                        // 在這裡放置延遲執行的程式碼
                        if self.isGameOver {
                            self.gameOverView.isHidden = false
                        } else {
                            self.initUI()
                            self.updateLevel()
                        }
                        
                    }
                    
                    break
                } else if (index == 3) {
                    winAcount += 1
                    DispatchQueue.main.asyncAfter(deadline: .now() + delayInSeconds) { [self] in
                        // 在這裡放置延遲執行的程式碼
                        self.initUI()
                        self.updateLevel()
                    }
                }
            }
        }
    }
    
    // 顯示結果畫面
    @IBSegueAction func showResult(_ coder: NSCoder) -> resultViewController? {
        let controller = resultViewController(coder: coder)
        controller?.heartsAcount = heartsImageView.count
        return controller
    }
}
