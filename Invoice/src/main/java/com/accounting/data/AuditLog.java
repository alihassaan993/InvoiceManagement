package com.accounting.data;

import java.sql.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.CreationTimestamp;

@Entity
@Table(name = "audit_log")
public class AuditLog {

	@Id
	@Column(name = "auditID")
	@GeneratedValue(strategy = GenerationType.IDENTITY)	
	private int auditID;
	
	@CreationTimestamp
	private Date logDate;

	
	@ManyToOne
	@JoinColumn(name="userID",nullable=false)
	private User user;
	
	private String details;
	public int getAuditID() {
		return auditID;
	}
	public void setAuditID(int auditID) {
		this.auditID = auditID;
	}
	public Date getLogDate() {
		return logDate;
	}
	public void setLogDate(Date logDate) {
		this.logDate = logDate;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public String getDetails() {
		return details;
	}
	public void setDetails(String details) {
		this.details = details;
	}
	
	
	
	
}
