package com.alexc.projectmanager.repositories;

import java.util.List;
import java.util.Optional;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.alexc.projectmanager.models.Project;
import com.alexc.projectmanager.models.User;

@Repository
public interface ProjectRepository extends CrudRepository<Project, Long> {
	List<Project> findAll();
	Project findByManagerIdIs(Long userId);
	List<Project> findAllByUsers(User user);
	List<Project> findByUsersNotContains(User user);
	Optional<Project> findProjectById(Long id);
}
