//
//  ViewController.swift
//  GustNumber
//
//  Created by Peggy Tsai on 2018/5/27.
//  Copyright © 2018年 Peggy Tsai. All rights reserved.
//

import UIKit
import GameplayKit

class ViewController: UIViewController {

    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var guessTimeLabel: UILabel!
    
    var randomDistribution: GKRandomDistribution!
    
    var answer = 0
    var maxNumber = 100
    var minNumber = 1
    var guessTime = 3

    @IBAction func makeGuessButton(_ sender: UIButton) {
        
        //判斷次數
        if sender.titleLabel?.text == "再玩一次" {
            sender.setTitle("猜數字", for: .normal)
            answer = randomDistribution.nextInt()
            print("1",answer)
            inputTextField.text = ""
            guessTime = 3
            maxNumber = 100
            minNumber = 1
            showInfo()
            
        } else if guessTime > 0 {
            
            guard let inputNumber = Int(inputTextField.text!) else{
                let alertController = UIAlertController(
                    title: "請輸入數字！",message: "",preferredStyle: .alert)
                
                // 建立[確認]按鈕
                let okAction = UIAlertAction(
                    title: "知道了！",style: .default,
                    handler: {
                        (action: UIAlertAction!) -> Void in print("沒輸入值")
                })
                
                alertController.addAction(okAction)
                
                // 顯示提示框
                self.present(alertController, animated: true, completion: nil)
                return
            }
    
            //數值超過範圍
            if (inputNumber > maxNumber) || (inputNumber < minNumber){
                
                let alertController = UIAlertController(
                    title: "數字輸入錯誤",message: "請輸入數字介於 \(minNumber) - \(maxNumber) 之間",
                    preferredStyle: .alert)
                
                // 建立[確認]按鈕
                let okAction = UIAlertAction(
                    title: "知道了！", style: .default,
                    handler: {
                        (action: UIAlertAction!) -> Void in print("數字輸入錯誤")
                })
                
                alertController.addAction(okAction)
                
                // 顯示提示框
                self.present(alertController, animated: true, completion: nil)
                
            } else {
                //修改最大值
                if inputNumber > answer {
                    maxNumber = inputNumber - 1
                    
                //修改最小值
                } else if inputNumber < answer {
                    minNumber = inputNumber + 1
                
                } else {
                    guessTimeLabel.text = "恭喜答對了！"
                    messageLabel.text = "按 \"再玩一次\" 按鈕 重新遊戲 "
                    sender.setTitle("再玩一次", for: .normal)
                    return
                }
                guessTime -= 1
                
                if guessTime == 0 {
                    guessTimeLabel.text = "遊戲結束，再玩一次"
                    sender.setTitle("再玩一次", for: .normal)
                    
                } else {
                    showInfo()
                    
                }
            }
        }
    }
    
    func showInfo() {
        guessTimeLabel.text = "還有 \(guessTime)次 機會"
        messageLabel.text = "請輸入數字介於 \(minNumber) - \(maxNumber) 之間"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        randomDistribution = GKRandomDistribution(lowestValue: 1, highestValue: 100)
        answer = randomDistribution.nextInt()
        print("0",answer)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

