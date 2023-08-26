package com.alexc.projectmanager.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alexc.projectmanager.models.Project;
import com.alexc.projectmanager.models.User;
import com.alexc.projectmanager.repositories.ProjectRepository;

@Service
public class ProjectService {
	@Autowired
	ProjectRepository projectRepo;
	
	
	public Project createProject(Project project, User user) {
		project.setManager(user);
		addUser(project, user);
		return projectRepo.save(project);
	}
	public void deleteProject(Project project) {
		projectRepo.delete(project);
	}
	public Project updateProject(Project project) {
		return projectRepo.save(project);
	}
	public Project findProject(Long id) {
		Optional<Project> optProj = projectRepo.findById(id);
		if(optProj.isPresent()) {
			return optProj.get();
		} else {
			return null;
		}
	}
	public List<Project> getAll() {
		return projectRepo.findAll();
	}
	public List<Project> unsignedProjects(User user) {
		return projectRepo.findByUsersNotContains(user);
	}
	public List<Project> signedProjects(User user) {
		return projectRepo.findAllByUsers(user);
	}
	public void addManager(Project project, User user) {
		project.setManager(user);
		projectRepo.save(project);
	}
	public void addUser(Project project, User user) {
		List<User> users = project.getUsers();
		users.add(user);
		project.setUsers(users);
		projectRepo.save(project);
	}
	public void removeUser(Project project, User user) {
		List<User> users = project.getUsers();
		if(users.contains(user)) {
			users.remove(user);
		}
		project.setUsers(users);
		projectRepo.save(project);
	}
	
}
