package model;

import java.util.Date;

import com.google.gson.annotations.Expose;

public class Lock {
	@Expose private String userName;
	@Expose private Date start;
	@Expose private Date end;
	private User user;
	private Long mid;
	/*
	 * auth表示权限。
	 * 0和未登录一样，只可浏览活动
	 * 1 可以报名活动，可以邀请朋友
	 * 2 可以对活动做出评论
	 * 3 可以发布活动
	 */
	@Expose private int auth;
	

	public Date getStart() {
		return start;
	}
	public void setStart(Date start) {
		this.start = start;
	}
	public Date getEnd() {
		return end;
	}
	public void setEnd(Date end) {
		this.end = end;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public Long getMid() {
		return mid;
	}
	public void setMid(Long mid) {
		this.mid = mid;
	}
	public int getAuth() {
		return auth;
	}
	public void setAuth(int auth) {
		this.auth = auth;
	}
	
	
}
