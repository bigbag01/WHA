package model;

import java.util.Set;

public class Activitycontent extends Activity{
	private String content;
	private Set<Message> comments;
	public Activitycontent(){}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Set<Message> getComments() {
		return comments;
	}
	public void setComments(Set<Message> comments) {
		this.comments = comments;
	}

}
