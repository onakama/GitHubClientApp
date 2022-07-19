//
//  Stateful.swift
//  GitHubClientApp
//
//  Created by onakama on 2022/07/19.
//

import Foundation

enum Stateful<Value> {
    case idle // まだデータを取得しにいっていない
    case loading // 読み込み中
    case failed(Error) // 読み込み失敗、遭遇したエラーを保持
    case loaded(Value) // 読み込み完了、読み込まれたデータを保持
}
