
import UIKit
import MessageKit
import InputBarAccessoryView
import Firebase
import FirebaseFirestore
import FirebaseAuth

final class MessageViewController: MessagesViewController {
    
    let uid = Auth.auth().currentUser?.uid
    let db = Firebase.Firestore.firestore()
    var roomID:String = ""
    private var messageList: [MessageEntity] = [] {
        didSet{
            messagesCollectionView.reloadData()
            messagesCollectionView.scrollToLastItem(at: .bottom, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //MARK:DELETE
        //   DispatchQueue.main.async {
        //   self.messageList = MessageEntity.mockMessages
        //    self.title = self.messageList.filter { !$0.isMe}.first?.userName
        // }
        
        db.collection("message")
            .whereField("roomNumber",isEqualTo: self.roomID)
            //FIXME: delete orderBy
            .addSnapshotListener{querySnapshot,error in
                guard let snapshot = querySnapshot else {return}
                snapshot.documentChanges.forEach{ diff in
                    var userId = diff.document.data()["userId"]as! String
                    let userName = diff.document.data()["userName"]as! String
                    let iconImageUrl = diff.document.data()["iconImageUrl"]as? String
                    let message = diff.document.data()["message"]as! String
                    let messageId = diff.document.data()["messageId"]as! String
                    let sentDate = diff.document.data()["sentDate"]as! Timestamp
                    let convertedDate: Date = sentDate.dateValue()
                    var stringToURL: URL?
                    if iconImageUrl != nil{
                        stringToURL = URL(string: iconImageUrl!)
                    }
                    
                    //                    self.messageList.append(["userId":userId,"userName":userName,"iconImageUrl":iconImageUrl,"message":message,"messageId":messageId,"sentDate":sentDate])
                    if userId == Auth.auth().currentUser?.uid{
                        let messageEntity = MessageEntity(userId: 0, userName: userName,iconImageUrl: stringToURL!,
                                                          message:message, messageId: messageId, sentDate: convertedDate)
                        self.messageList.append(messageEntity)
                        self.messagesCollectionView.reloadData()
                        
                        
                    }else {
                        let messageEntity = MessageEntity(userId: 1, userName: userName,iconImageUrl: stringToURL!,
                                                          message:message, messageId: messageId, sentDate: convertedDate)
                        self.messageList.append(messageEntity)
                    }
                                        //FIXME: sort messageList
                                        self.messageList = self.messageList.sorted { firstEntity, secondEntity in
                                            firstEntity.sentDate.compare(secondEntity.sentDate) == .orderedAscending
                                        }
                        self.messagesCollectionView.reloadData()
                        
                    }
                    
                }
            }
        messagesCollectionView.backgroundColor = UIColor.secondarySystemBackground
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        messageInputBar.delegate = self
        messageInputBar.sendButton.title = nil
        messageInputBar.sendButton.image = UIImage(systemName: "paperplane")
    }
    
}

extension MessageViewController: MessagesDataSource{
    var currentSender: SenderType {
        return MessageSenderType.me
    }
    
    //    func currrentSender() -> SenderType {
    //
    //    }
    
    func otherSender() -> SenderType {
        return MessageSenderType.other
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messageList.count
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messageList[indexPath.section]
    }
    
    func messageTopLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        return NSAttributedString(
            string: messageList[indexPath.section].userName,
            attributes: [.font: UIFont.systemFont(ofSize: 12.0),
                         .foregroundColor: UIColor.systemBlue])
    }
    
    func messageBottomLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        return NSAttributedString(
            string: messageList[indexPath.section].bottomText,
            attributes: [.font: UIFont.systemFont(ofSize: 12.0),
                         .foregroundColor: UIColor.secondaryLabel])
    }
}

extension MessageViewController: MessagesDisplayDelegate {
    func backgroundColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return isFromCurrentSender(message: message) ? UIColor.systemBlue : UIColor.systemBackground
    }
    
    func messageStyle(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageStyle {
        let corner: MessageStyle.TailCorner = isFromCurrentSender(message: message) ? .bottomRight : .bottomLeft
        return .bubbleTail(corner, .curved)
    }
    
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        guard let url = messageList[indexPath.section].iconImageUrl else{return}
        let data: Data?
        do {
            data = try Data(contentsOf: url )} catch{
                print(error)
                return
            }
        avatarView.set(avatar: Avatar(image: UIImage(data: data!), initials: ""))
        //        avatarView.set(url: messageList[indexPath.section].iconImageUrl)
    }
}

// MARK: MessagesLayoutDelegate
extension MessageViewController: MessagesLayoutDelegate {
    func headerViewSize(for section: Int, in messagesCollectionView: MessagesCollectionView) -> CGSize {
        return CGSize.zero
    }
    
    func messageTopLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        return 24
    }
    
    func messageBottomLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        return 24
    }
}

// MARK: InputBarAccessoryViewDelegate
extension MessageViewController: InputBarAccessoryViewDelegate {
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        let messageEntity = MessageEntity(userId: 0, userName: self.userName, message: text, messageId: UUID().uuidString, sentDate: Date())
        
        let addData = [
            "userName":self.userName,
            "userId": self.uid,
            "iconImageUrl":MessageEntity.myIconImageUrl.absoluteString,
            "message":text,
            "messageId":messageEntity.messageId,
            "sentDate":Timestamp(date: Date()),
            "roomNumber":roomID] as [String : Any]
        
        
        messageInputBar.inputTextView.text = String()
        
        db.collection("message")
            .addDocument(data: addData){err in
                
                
                if let error = err {
                    print("メッセージの保存に失敗しました：\(error)")
                }
    }
}
}
