//
//  ViewController.swift
//  Calculator
//
//  Created by Shelley Shyan on 15-3-9.
//  Copyright (c) 2015年 Sanfriend Technology Co., Ltd. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{

    @IBOutlet weak var 显示标签: UILabel!
    
    var 正在输入: Bool = false
    var 模型 = 计算大脑()
    
    @IBAction func 追加数字(发送者: UIButton) {
        let 数字 = 发送者.currentTitle!
        if 正在输入 {
            显示标签.text = 显示标签.text! + 数字
        } else {
            显示标签.text = 数字
            正在输入 = true
        }
    }
    
    @IBAction func 操作(发送者: UIButton) {
        if 正在输入 {
            回车()
        }

        if let 操作 = 发送者.currentTitle {
            if let 结果 = 模型.执行操作(操作) {
                显示值 = 结果
            } else {
                显示值 = 0
            }
        }
    }
    
    @IBAction func 回车() {
        正在输入 = false
        if let 结果 = 模型.压入操作数(显示值) {
            显示值 = 结果
        } else {
            显示值 = 0
        }
    }
    
    var 显示值: Double {
        get {
            return NSNumberFormatter().numberFromString(显示标签.text!)!.doubleValue
        }
        set {
            // newValue 为编译器定义的名, 不能修改
            显示标签.text = "\(newValue)"
        }
    }
}
