package mboard.vo;

public class MemberVo {
	
	// field
	private String id;
	private String password;
	private String email;
	private String nickname;

	
	// constructor
	
	public MemberVo() {
		
	}
	
	public MemberVo(String id, String password, String email, String nickname) {
		this.id = id;
		this.password = password;
		this.email = email;
		this.nickname = nickname;
	}

	public MemberVo(String id, String nickname) {
		this.id = id;
		this.nickname = nickname;
	}

	// Getter / Setter
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	// method
	public String toHtmlString(String in_id) {
		String tag = "";
		tag += "<tr>";
		tag += "<td>" + this.id    + "</td>";
		if(this.id.equals(in_id)) {
			tag += "<td>" + this.password   + "</td>";	
		} else {
			tag += "<td>*******</td>";		
		}
		tag += "<td>" + this.email      + "</td>";
		tag += "<td>" + this.nickname    + "</td>";
		tag += "</tr>";
		return tag;
	}

	// toString
	@Override
	public String toString() {
		return "MemberVo [id=" + id + ", password=" + password + ", email=" + email + ", nickname=" + nickname + "]";
	}
	
}
