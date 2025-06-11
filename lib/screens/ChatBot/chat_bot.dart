import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/services/chat_service.dart';

class Message {
  final String text;
  final bool isUser;
  final DateTime timestamp;

  Message({
    required this.text, 
    required this.isUser,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();
}

void sendMessage(){
  
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  final ChatService _chatService = ChatService();
  final List<Message> _messages = [];
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;
  bool _isTyping = false;
  late AnimationController _typingAnimationController;

  @override
  void initState() {
    super.initState();
    _typingAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    _typingAnimationController.dispose();
    super.dispose();
  }

  Future<void> _sendMessage() async {
    if (_controller.text.trim().isEmpty) return;

    final userMessage = _controller.text;
    setState(() {
      _messages.add(Message(text: userMessage, isUser: true));
      _isLoading = true;
      _isTyping = true;
    });
    _controller.clear();
    
    // Scroll to bottom
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });

    // Add haptic feedback
    HapticFeedback.lightImpact();

    try {
      // Simulate typing delay for better UX
      await Future.delayed(const Duration(milliseconds: 500));
      
      final response = await _chatService.sendMessage(userMessage);
      setState(() {
        _messages.add(Message(text: response, isUser: false));
        _isLoading = false;
        _isTyping = false;
      });
    } catch (e) {
      setState(() {
        _messages.add(Message(
          text: 'Sorry, there was an error processing your message. Please try again.',
          isUser: false,
        ));
        _isLoading = false;
        _isTyping = false;
      });
    }

    // Scroll to bottom after response
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: _buildMessagesList(),
          ),
          if (_isTyping) _buildTypingIndicator(),
          _buildInputField(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.fromLTRB(20, MediaQuery.of(context).padding.top + 10, 20, 15),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.pink[300]!, Colors.pink[400]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.pink[200]!.withOpacity(0.3),
            offset: const Offset(0, 2),
            blurRadius: 8,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: CircleAvatar(
              radius: 18,
              backgroundColor: Colors.pink[50],
              child: Icon(
                Icons.smart_toy_rounded,
                color: Colors.pink[400],
                size: 20,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'AI Assistant',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      'Online',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {
              // Menu options
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMessagesList() {
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      itemCount: _messages.length,
      itemBuilder: (context, index) {
        return AnimatedContainer(
          duration: Duration(milliseconds: 300 + (index * 50)),
          curve: Curves.easeOutBack,
          child: _buildMessageBubble(_messages[index], index),
        );
      },
    );
  }

  Widget _buildMessageBubble(Message message, int index) {
    final isUser = message.isUser;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isUser) _buildAvatar(false),
          if (!isUser) const SizedBox(width: 8),
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.75,
              ),
              child: Column(
                crossAxisAlignment: isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Hero(
                    tag: 'message_$index',
                    child: Material(
                      color: Colors.transparent,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          gradient: isUser 
                            ? LinearGradient(
                                colors: [Colors.pink[300]!, Colors.pink[400]!],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              )
                            : null,
                          color: isUser ? null : Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(20),
                            topRight: const Radius.circular(20),
                            bottomLeft: Radius.circular(isUser ? 20 : 4),
                            bottomRight: Radius.circular(isUser ? 4 : 20),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              offset: const Offset(0, 2),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: Text(
                          message.text,
                          style: TextStyle(
                            color: isUser ? Colors.white : Colors.grey[800],
                            fontSize: 15,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _formatTime(message.timestamp),
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isUser) const SizedBox(width: 8),
          if (isUser) _buildAvatar(true),
        ],
      ),
    );
  }

  Widget _buildAvatar(bool isUser) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: CircleAvatar(
        radius: 16,
        backgroundColor: isUser ? Colors.grey[200] : Colors.pink[50],
        backgroundImage: isUser ? const AssetImage("assets/3.png") : null,
        child: isUser
            ? null
            : Icon(
                Icons.smart_toy_rounded,
                color: Colors.pink[400],
                size: 16,
              ),
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          _buildAvatar(false),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  offset: const Offset(0, 2),
                  blurRadius: 4,
                ),
              ],
            ),
            child: AnimatedBuilder(
              animation: _typingAnimationController,
              builder: (context, child) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(3, (index) {
                    final delay = index * 0.2;
                    final animationValue = (_typingAnimationController.value - delay).clamp(0.0, 1.0);
                    final opacity = (animationValue * 2).clamp(0.0, 1.0);
                    
                    return Container(
                      margin: const EdgeInsets.only(right: 4),
                      child: AnimatedOpacity(
                        opacity: opacity > 1 ? 2 - opacity : opacity,
                        duration: const Duration(milliseconds: 100),
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: Colors.grey[400],
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    );
                  }),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField() {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 12, 16, MediaQuery.of(context).padding.bottom + 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, -2),
            blurRadius: 8,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.pink[50]!, Colors.pink[100]!],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: Colors.pink[200]!,
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      maxLines: null,
                      decoration: InputDecoration(
                        hintText: 'Type your message...',
                        hintStyle: TextStyle(
                          color: Colors.pink[300],
                          fontSize: 15,
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                      ),
                      style: TextStyle(
                        color: Colors.pink[700],
                        fontSize: 15,
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 4),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(25),
                        onTap: _isLoading ? null : () {
                          // Voice input logic
                          HapticFeedback.lightImpact();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          child: Icon(
                            Icons.mic_rounded,
                            color: _isLoading ? Colors.grey[400] : Colors.pink[400],
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 4),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.pink[300]!, Colors.pink[400]!],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(25),
                        onTap: _isLoading ? null : _sendMessage,
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          child: Icon(
                            _isLoading ? Icons.hourglass_empty : Icons.send_rounded,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    
    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inDays < 1) {
      return '${difference.inHours}h ago';
    } else {
      return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    }
  }
}