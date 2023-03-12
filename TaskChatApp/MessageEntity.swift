//
//  MessageEntity.swift
//  TaskChatApp
//
//  Created by 卓馬純之介 on 2023/01/29.
//

import Foundation
import MessageKit
import UIKit

struct MessageEntity: MessageType{
    var userId: Int
    var userName:String
    var iconImageUrl: URL?
    var message: String
    var messageId: String
    var sentDate: Date
    
    var kind: MessageKind {
        return .attributedText(NSAttributedString(
            string: message,
            attributes: [.font: UIFont.systemFont(ofSize: 14.0),
                         .foregroundColor: isMe
                         ?UIColor.white
                              :UIColor.label]
        ))
    }
    
    var sender: SenderType {
        return isMe ? MessageSenderType.me : MessageSenderType.other
    }
    
    var isMe: Bool{
        userId == 0
    }
    
    var bottomText: String {
        return sentDate.yyyyMMddHHmm
    }
    
    //MARK: static new
//    static func new(my message: String,
//                    date: Date = Date(),
//                    isMarkAsRead: Bool = false) -> MessageEntity{
//        return MessageEntity(
//            userId: 0,
//            userName: "自分",
//            iconImageUrl: myIconImageUrl,
//            message: message,
//            messageId: UUID().uuidString,
//            sentDate: date)
//    }
//
//    static func new(other message: String,
//                    date: Date = Date()) -> MessageEntity {
//        return MessageEntity(
//            userId: 1,
//            userName: "相手",
//            iconImageUrl: otherIconImageUrl,
//            message: message,
//            messageId: UUID().uuidString,
//            sentDate: date)
//    }
    
    //MARK: MockData
    static var myIconImageUrl: URL = URL(string:"xxx")!
    static var otherIconImageUrl: URL = URL(string: "xxx")!
    
//    static var mockMessages: [MessageEntity]{
//        return [MessageEntity.new(other:"黒は英語で？",date: Date().oneMonthBefore.oneMonthBefore.yesterday),
//                MessageEntity.new(my:"Black!",date:Date().oneMonthBefore.oneMonthBefore, isMarkAsRead: true),
//                MessageEntity.new(other:"白は英語で？",date: Date().oneMonthBefore.beginningOfTheMonth.yesterday),
//                MessageEntity.new(my:"White!",date:Date().oneMonthBefore.beginningOfTheMonth, isMarkAsRead:true),
//                MessageEntity.new(other:"赤は英語で？",date: Date().oneMonthBefore.yesterday),
//                MessageEntity.new(my:"Red!",date:Date().oneMonthBefore, isMarkAsRead: true),
//                MessageEntity.new(other:"青は英語で？",date: Date().yesterday),
//                MessageEntity.new(my:"Black!",date:Date().yesterday.hourAfter(1),isMarkAsRead: true),
//                MessageEntity.new(other:"黄色は英語で？",date:Date())]
//    }
}

import MessageKit

struct MessageSenderType: SenderType {
    var senderId: String
    var displayName: String
    
    static var me: MessageSenderType {
        return MessageSenderType(senderId: "0",
                                 displayName:"me")
    }
    
    static var other: MessageSenderType {
        return MessageSenderType(senderId:"1",
                                 displayName: "other")
    }
}

