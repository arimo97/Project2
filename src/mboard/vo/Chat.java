package mboard.vo;

public class Chat {
	int	chatNum;
	String chatName;
	String chatContent;
	String chatTime;
	String chatIp;
	
	
	public String getChatIp() {
		return chatIp;
	}
	public void setChatIp(String chatIp) {
		this.chatIp = chatIp;
	}
	public int getChatID() {
		return chatNum;
	}
	public void setChatID(int chatID) {
		this.chatNum = chatID;
	}
	public String getChatName() {
		return chatName;
	}
	public void setChatName(String chatName) {
		this.chatName = chatName;
	}
	public String getChatContent() {
		return chatContent;
	}
	public void setChatContent(String chatContent) {
		this.chatContent = chatContent;
	}
	public String getChatTime() {
		return chatTime;
	}
	public void setChatTime(String chatTime) {
		this.chatTime = chatTime;
	}
	
}
