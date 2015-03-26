//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Shelley Shyan on 15-3-9.
//  Copyright (c) 2015年 Sanfriend Technology Co., Ltd. All rights reserved.
//

import Foundation

class 计算大脑
{
    private enum 操作: Printable {
        case 操作数(Double)
        case 一元操作(String, Double -> Double)
        case 二元操作(String, (Double, Double) -> Double)

        // description 不能定义成中文: 要遵守 Printable 协议.
        var description: String {
            get {
                switch self {
                case .操作数(let 操作数):
                    return "\(操作数)"
                case .一元操作(let 符号, _):
                    return 符号
                case .二元操作(let 符号, _):
                    return 符号
                }
            }
        }
    }

    private var 操作栈 = [操作]()
    private var 已知操作 = [String:操作]()
    
    init() {
        func 学习操作(新操作: 操作) {
            已知操作[新操作.description] = 新操作
        }

        学习操作(操作.二元操作("×", *))
        学习操作(操作.二元操作("÷") {$1 / $0})
        学习操作(操作.二元操作("+", +))
        学习操作(操作.二元操作("−") {$1 - $0})
        学习操作(操作.一元操作("√", sqrt))
    }
    
    private func 运算(操作栈:[操作]) -> (结果: Double?, 剩余操作:[操作]) {
        if !操作栈.isEmpty {
            var 剩余操作 = 操作栈
            let 当前操作 = 剩余操作.removeLast()

            switch 当前操作 {
            case .操作数(let 操作数):
                return (操作数, 剩余操作)
            case .一元操作(_, let 操作类型):
                let 运算结果 = 运算(剩余操作)
                if let 操作数 = 运算结果.结果 {
                    return (操作类型(操作数), 运算结果.剩余操作)
                }
            case .二元操作(_, let 操作类型):
                let 运算结果1 = 运算(剩余操作)
                if let 数1 = 运算结果1.结果 {
                    let 运算结果2 = 运算(运算结果1.剩余操作)
                    if let 数2 = 运算结果2.结果 {
                        return (操作类型(数1, 数2), 运算结果2.剩余操作)
                    }
                }
            }
        }
        return (nil, 操作栈)
    }

    func 运算() -> Double? {
        let (结果, _) = 运算(操作栈)
        return 结果
    }

    func 压入操作数(操作数: Double) -> Double? {
        操作栈.append(操作.操作数(操作数))
        return 运算()
    }
    
    func 执行操作(符号:String) ->Double? {
        if let 操作 = 已知操作[符号] {
            操作栈.append(操作)
        }
        return 运算()
    }
    
}


