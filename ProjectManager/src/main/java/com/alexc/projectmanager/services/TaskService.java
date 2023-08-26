package com.alexc.projectmanager.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alexc.projectmanager.models.Project;
import com.alexc.projectmanager.models.Task;
import com.alexc.projectmanager.models.User;
import com.alexc.projectmanager.repositories.TaskRepository;

@Service
public class TaskService {
	@Autowired
	TaskRepository taskRepo;
	
	public Task newTask(Task task) {
		return taskRepo.save(task);
	}
	public List<Task> getAll() {
		return taskRepo.findAll();
	}
}
