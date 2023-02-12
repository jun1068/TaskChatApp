
import UIKit
import MessageKit
import InputBarAccessoryView

final class MessageViewController: MessagesViewController {
    
    private var messageList: [MessageEntity] = [] {
        didSet{
            messagesCollectionView.reloadData()
            messagesCollectionView.scrollToLastItem(at: .bottom, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.messageList = MessageEntity.mockMessages
            self.title = self.messageList.filter { !$0.isMe}.first?.userName
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
        avatarView.set(url: messageList[indexPath.section].iconImageUrl)
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
        //
        messageList.append(MessageEntity.new(my: text))
        messageInputBar.inputTextView.text = String()
    }
}
