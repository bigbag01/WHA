package model;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

public class Activity {
	private Long aid;
	private User publisher;
	private String sponsor;
	private String head;
	private Date aplstart;
	private Date aplend;
	private Date actstart;
	private Date actend;
	private String location;
	private int limitation;
	private String posterpath;
	private String status;
	private Set<User> users;
	private int category;
	private List<String> keywords;
	//0表示讲座，1表示招聘，2表示招新，3表示比赛，4表示游学，5表示艺术，6表示户外，7表示其他
	private Map<String,Integer> ranks=new HashMap();
	public Long getAid() {
		return aid;
	}
	public void setAid(Long aid) {
		this.aid = aid;
	}
	public User getPublisher() {
		return publisher;
	}
	public void setPublisher(User publisher) {
		this.publisher = publisher;
	}
	public String getSponsor() {
		return sponsor;
	}
	public void setSponsor(String sponsor) {
		this.sponsor = sponsor;
	}
	public String getHead() {
		return head;
	}
	public void setHead(String head) {
		this.head = head;
	}
	public Date getAplstart() {
		return aplstart;
	}
	public void setAplstart(Date aplstart) {
		this.aplstart = aplstart;
	}
	public Date getAplend() {
		return aplend;
	}
	public void setAplend(Date aplend) {
		this.aplend = aplend;
	}
	public Date getActstart() {
		return actstart;
	}
	public void setActstart(Date actstart) {
		this.actstart = actstart;
	}
	public Date getActend() {
		return actend;
	}
	public void setActend(Date actend) {
		this.actend = actend;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public int getLimitation() {
		return limitation;
	}
	public void setLimitation(int limitation) {
		this.limitation = limitation;
	}
	public String getPosterpath() {
		return posterpath;
	}
	public void setPosterpath(String posterpath) {
		this.posterpath = posterpath;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public Set<User> getUsers() {
		return users;
	}
	public void setUsers(Set<User> users) {
		this.users = users;
	}
	/*public Set<User> getAttenders() {
		return attenders;
	}
	public void setAttenders(Set<User> attenders) {
		this.attenders = attenders;
	}*/
	public Map<String, Integer> getRanks() {
		return ranks;
	}
	public int getCategory() {
		return category;
	}
	public void setCategory(int category) {
		this.category = category;
	}
	public void setRanks(Map<String, Integer> ranks) {
		this.ranks = ranks;
	}
	public List<String> getKeywords() {
		return keywords;
	}
	public void setKeywords(List<String> keywords) {
		this.keywords = keywords;
	}
	
}
