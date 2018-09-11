//
//  FlashCardSetting.swift
//  MyApp
//
//  Created by PCM0019 on 8/11/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers final class FlashCardSetting: Object {
    // MARK: - Properties
    dynamic var timeMove: Int = 3
    dynamic var timeToTurnOff: Int = 60
    dynamic var autoRepeat = true
    dynamic var autoSpeak = true
}
