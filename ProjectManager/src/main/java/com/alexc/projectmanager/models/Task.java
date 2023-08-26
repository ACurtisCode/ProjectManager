	package com.alexc.projectmanager.models;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.PrePersist;
import javax.persistence.PreUpdate;
import javax.persistence.Table;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Size;

@Entity
@Table(name = "tasks")
public class Task {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@NotEmpty(message = "A task is required")
	@Size(min = 5, message = "task must be at least 5 characters")
	private String mission;


	@Column(updatable = false)
	private Date createdAt;
	private Date updatedAt;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name="project_id")
	private Project taskedProject;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name="task_id")
	private User taskOwner;
	
	public Task() {
		
	}
	public Task(String mission) {
		this.mission = mission;
	}
	public Date getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}

	

	@PrePersist
	protected void onCreate() {
		this.createdAt = new Date();
	}

	@PreUpdate
	protected void onUpdate() {
		this.updatedAt = new Date();
	}
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getMission() {
		return mission;
	}

	public void setMission(String mission) {
		this.mission = mission;
	}

	public Project getTaskedProject() {
		return taskedProject;
	}

	public void setTaskedProject(Project taskedProject) {
		this.taskedProject = taskedProject;
	}

	public User getTaskOwner() {
		return taskOwner;
	}

	public void setTaskOwner(User taskOwner) {
		this.taskOwner = taskOwner;
	}

}
