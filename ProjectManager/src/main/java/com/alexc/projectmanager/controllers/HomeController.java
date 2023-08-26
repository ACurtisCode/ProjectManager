package com.alexc.projectmanager.controllers;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import com.alexc.projectmanager.models.LoginUser;
import com.alexc.projectmanager.models.Project;
import com.alexc.projectmanager.models.Task;
import com.alexc.projectmanager.models.User;
import com.alexc.projectmanager.services.ProjectService;
import com.alexc.projectmanager.services.TaskService;
import com.alexc.projectmanager.services.UserService;

@Controller
public class HomeController {
	@Autowired
	UserService userServ;
	@Autowired
	ProjectService projServ;
	@Autowired
	TaskService taskServ;

	@GetMapping("/")
	public String index(Model model) {
		model.addAttribute("newUser", new User());
		model.addAttribute("newLogin", new LoginUser());
		return "Home.jsp";
	}

	@PostMapping("/register")
	public String register(@Valid @ModelAttribute("newUser") User newUser, BindingResult result, Model model,
			HttpSession session) {

		User user = userServ.register(newUser, result);
		if (result.hasErrors()) {
			model.addAttribute("newLogin", new LoginUser());
			return "Home.jsp";
		}

		session.setAttribute("userId", newUser.getId());
		return "redirect:/dashboard";
	}

	@PostMapping("/login")
	public String login(@Valid @ModelAttribute("newLogin") LoginUser newLogin, BindingResult result, Model model,
			HttpSession session) {

		User user = userServ.login(newLogin, result);

		if (result.hasErrors()) {
			model.addAttribute("newUser", new User());
			return "Home.jsp";
		}

		session.setAttribute("userId", user.getId());
		return "redirect:/dashboard";
	}

	@GetMapping("/logout")
	public String logout(HttpSession session, Model model) {
		session.setAttribute("userId", null);
		return "redirect:/";
	}

	@GetMapping("/dashboard")
	public String dashboard(Model model, HttpSession session) {
		Long userId = (Long) session.getAttribute("userId");
		if (userId == null) {
			return "redirect:/logout";
		}
		User user = userServ.findUser(userId);
		List<Project> freeProjects = projServ.unsignedProjects(user);
		List<Project> ownProjects = projServ.signedProjects(user);
		
		model.addAttribute("user", user);
		model.addAttribute("ownedProjects", ownProjects);
		model.addAttribute("freeProjects", freeProjects);
		return "Dashboard.jsp";
	}
	
	@GetMapping("/projects/new")
	public String newProject(@ModelAttribute("newProject") Project project, Model model, HttpSession session) {
		Date date = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		String paramDate = formatter.format(date);
		model.addAttribute("date", paramDate);
		return "NewProject.jsp";
	}
	@PostMapping("/project/add")
	public String addProject(@Valid @ModelAttribute("newProject") Project project, BindingResult result, Model model, HttpSession session) {
		Long userId = (Long) session.getAttribute("userId");
		if(userId==null) {
			return "redirect:/logout";
		}
		User user = userServ.findUser(userId);
		if(result.hasErrors()) {
			return "NewProject.jsp";
		} else {
			projServ.createProject(project, user);
			return "redirect:/dashboard";
		}
	}
	
	@GetMapping("/projects/edit/{id}")
	public String editProject(@PathVariable("id") Long id, Model model, HttpSession session) {
		Date date = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		String paramDate = formatter.format(date);
		model.addAttribute("date", paramDate);
		Project project = projServ.findProject(id);
		model.addAttribute("updateProject", project);
		return "EditProject.jsp";
	}
	@PostMapping("/projects/edit/{id}")
	public String updateProject(@PathVariable("id") Long id, @Valid @ModelAttribute("updateProject") Project project, Model model, BindingResult result, HttpSession session) {
		Long userId = (Long)session.getAttribute("userId");
		User user = userServ.findUser(userId);
		
		if(result.hasErrors()) {
			return "EditProject.jsp";
		} else {
			Project updateProject = projServ.findProject(id);
			project.setUsers(updateProject.getUsers());
			project.setManager(user);
			projServ.updateProject(project);
			
			return "redirect:/dashboard";
		}
	}
	@GetMapping("/projects/join/{id}")
	public String joinProject(@PathVariable("id") Long id, Model model, HttpSession session) {
		User user = userServ.findUser((Long) session.getAttribute("userId"));
		Project project = projServ.findProject(id);
		projServ.addUser(project, user);
		return "redirect:/dashboard";
	}
	@GetMapping("/projects/leave/{id}")
	public String leaveProject(@PathVariable("id") Long id, Model model, HttpSession session) {
		User user = userServ.findUser((Long) session.getAttribute("userId"));
		Project project = projServ.findProject(id);
		projServ.removeUser(project, user);
		return "redirect:/dashboard";
	}
	@GetMapping("/projects/{id}")
	public String showProject(@PathVariable("id") Long id, Model model, HttpSession session) {
		Project project = projServ.findProject(id);
		User user = userServ.findUser((Long)session.getAttribute("userId"));
		model.addAttribute("user", user);
		model.addAttribute("project", project);
		return "ShowProject.jsp";
	}
	@PostMapping("/delete/{id}")
	public String deleteProject(@PathVariable("id") Long id, HttpSession session) {
		Project project = projServ.findProject(id);
		projServ.deleteProject(project);
		return "redirect:/dashboard";
	}
	
	@GetMapping("/projects/{id}/tasks")
	public String projectTasks(@PathVariable("id") Long id, @ModelAttribute("task") Task task, Model model, HttpSession session) {
		Project project = projServ.findProject(id);
		List<Task> taskList = project.getTasks();
		model.addAttribute("project", project);
		model.addAttribute("taskList", taskList);
		return "ProjectTasks.jsp";
	}
	@PostMapping("/add/task/{id}")
	public String addTask(@PathVariable("id") Long id, @Valid @ModelAttribute("task") Task task, Model model, BindingResult result, HttpSession session) {
		Project project = projServ.findProject(id);
		User user = userServ.findUser((Long)session.getAttribute("userId"));
		if(result.hasErrors()) {
			List<Task> taskList = project.getTasks();
			model.addAttribute("project", project);
			model.addAttribute("taskList", taskList);
			return "TaskService.jsp";
		} else {
			Task newTask = new Task(task.getMission());
			newTask.setTaskedProject(project);
			newTask.setTaskOwner(user);
			taskServ.newTask(newTask);
			return "redirect:/projects/" + id + "/tasks";
		}
	}
}













