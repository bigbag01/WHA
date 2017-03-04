package model;

import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import org.apache.commons.lang3.tuple.Pair;

import com.google.gson.annotations.Expose;

public class User {
	@Expose private String userName;
	private String password;
	@Expose private String email;
	@Expose private String phone;
	@Expose private String gender;
	private Set<Activity> activities;
	//private Set<Activity> attends;
	private Set<Message> mysends;
	private Set<Message> myreceipts;
	private Lock mylock;
	private Map<String,String> userProfile=new HashMap();

	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
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
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public Set<Activity> getActivities() {
		return activities;
	}
	public void setActivities(Set<Activity> activities) {
		this.activities = activities;
	}
	/*public Set<Activity> getAttends() {
		return attends;
	}
	public void setAttends(Set<Activity> attends) {
		this.attends = attends;
	}*/
	public Set<Message> getMysends() {
		return mysends;
	}
	public void setMysends(Set<Message> mysends) {
		this.mysends = mysends;
	}
	public Set<Message> getMyreceipts() {
		return myreceipts;
	}
	public void setMyreceipts(Set<Message> myreceipts) {
		this.myreceipts = myreceipts;
	}
	public Lock getMylock() {
		return mylock;
	}
	public void setMylock(Lock mylock) {
		this.mylock = mylock;
	}
	public Map<String, String> getUserProfile() {
		return userProfile;
	}
	public void setUserProfile(Map<String, String> userProfile) {
		this.userProfile = userProfile;
	}
	public boolean equals(Object obj) {
	        if (obj instanceof User) {
	            User user = (User) obj;
	            //System.out.println("equal"+ user.userName);
	            return (userName.equals(user.userName));
	        }
	        return super.equals(obj);
	 }
	        
	    public int hashCode() {
	        return userName.hashCode();
	            
	    }

	
}
