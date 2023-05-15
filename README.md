# TicketTracker
CS157A Final Project

Executive Summary

In any modern business, technology plays a significant role. Even in non-tech based companies, employees make frequent use of personal computers, the internet, data, and databases. Thus, every modern company needs technology experts in order to function smoothly and efficiently. The IT department is the center of any business’s intra-company technology operation. One common aspect of an IT department is the helpdesk, a group of employees whose responsibilities include addressing technological issues experienced by other company employees. 
	In order to keep tasks organized, many helpdesk departments make use of ticketing software, which allows employees to submit request directly to the IT group where those requests can then be categorized, assigned, and addressed in a logical manner. The TicketTracker application is one such system: it offers the ability for employees to submit tickets, the ability for helpdesk agents to view, assign, and resolve those tickets, and the ability for a department manager or head of IT to see an overview of the department’s performance as well as to investigate the performance of individual agents. 
	The design of TicketTracker’s database involves keeping track of employee accounts, employee permissions, and tickets. Employees with different levels of permission (regular employee, helpdesk employee, and manager) should have access to increasing amounts of internal department information. A regular employee is limited to submitting tickets and viewing tickets they have previously submitted, with some limited information about the status of those tickets. Helpdesk agents can view information about all submitted open tickets, assign tickets to themselves, and mark tickets as resolved once the stated issue has been addressed. Agents can also take a look at their own stat report in order to view the number of tickets they have resolved, the number still pending, and the amount of time it takes them on average to resolve a ticket. Managers, meanwhile, have access to the resolution statistics for the entire department, and are able to view general department performance and the performance of individual agents. Each higher level of permission also grants access to the same views and capabilities of the lower permission levels. 
	TicketTracker was implemented using SQLite and Java. The database was built using SQLite, the frontend was created with JavaFX, a graphical interface creation plugin, and the backend uses a combination of standard Java and an additional plugin, SQLite JDBC, which allows the Java program to interface with the database directly. 
	Testing the application first involved populating the database with sample user accounts of varying permission levels. Then, each sample account (all permission levels) was used to submit various tickets and ensure that they could view all of their own tickets. The agent accounts were used to assign and resolve some tickets, and then to ensure that their individual statistics reflected accurate information regarding ticket totals and average time calculation. The manager dashboard was also tested for accuracy. 
	In conclusion, TicketTracker successfully achieves its goals. Users are limited in the amount of data they can access based on their permission level, and they interface with the database through an application layer to ensure that they cannot access additional data on department operations. Higher permission levels have the ability to view all pertinent data from the database. The manager dashboard successfully and accurately reflects department statistics, which can help any department manager maintain an up-to-date grasp of the performance of the department and its employees.
	
Background

	The tech boom of the last few decades has given rise to the ubiquitous IT (information technology) department. For any modern business to operate successfully, technology must be put to use effectively and efficiently. While an IT department for any given business has certain responsibilities regarding creating and maintaining company technologies, networks, data storage, and more, they are also inevitably tasked with problem-solving and troubleshooting technology issues brought forth by company employees. 
	At a large enough business, an IT department will employ helpdesk agents, whose responsibility it is to respond to and resolve daily technological issues, and to assist individual company employees with their personal technological needs (within the scope of company operations). In order to track and manage employee requests, the IT team will typically make use of ticketing software: a program which allows employees to submit requests directly to the helpdesk, and then allows agents to view, categorize, and address the tickets as they enter the system.

Problem Statement

	While helpdesk agents may use ticketing software to keep track of tickets, IT managers also need a way to keep track of agents’ performance and the performance of the department as a whole. TicketTracker is a ticketing software which will perform the typical functions of a ticketing system – allowing employees to submit tickets and allowing agents to keep track of tickets submitted – and which also provides a manager dashboard for the department manager to view the progress and efficiency of each agent as well as the department overall. Each agent as well as the manager should have the ability to submit tickets, and the manager should also have the ability to address tickets themselves. Therefore there are three permission levels: employee, agent, and manager, where each ascending level can also view the information and have access to the capabilities of the preceding levels. 
	Using the manager dashboard, the IT department manager can easily see where department shortcomings lie, and make determinations about how best to improve the effectiveness of the department. Helpdesk agents can also view their own ticket resolution stats in order to gauge their own effectiveness, while being unable to view the statistics of their fellow employees.

Design

Conceptual Design

There are three views available to three different roles in the company: an employee view, an agent view, and a manager view. A regular employee should be able to submit a new ticket and view the tickets they have previously submitted. An agent should be able to view unassigned tickets, assign a ticket to themselves, view their assigned tickets, and change the status of a ticket (open or resolved). An agent should additionally be able to view their own statistics including total numbers of open and closed tickets, and average amount of time spent resolving a ticket. A manager should be able to view the stats of all of their agents as well as the tickets assigned to each agent, and they should be able to view general stats for the department. To complicate matters, agents and managers are both employees, and managers are also agents.

Conceptual Entities and Attributes:
	
	ROLE: name
	EMPLOYEE: first_name, last_name, manager, role, (ticket_submitted, date_submitted, 	assigned_agent, ticket_status, date_resolved), (ticket_assigned, date_assigned, 	submitting_employee, ticket_status, date_resolved), num_open_tickets, num_closed_tickets, 	avg_resolution_time), (employee, first_name, last_name, (tickets_assigned), num_open_tickets, 	num_resolved_tickets, avg_resolution_time), department_num_tickets_assigned, 	department_avg_resolution_time
	ACCOUNT: username, password
	TICKET: title, message, submitting_employee, agent_assigned, date_submitted, date_assigned, 	date_resolved, time_to_resolution
	
Logical Design

1NF Relations:

	ROLE: name
	EMPLOYEE: employee_id, first_name, last_name, role
	AGENT: agent_id, num_open_tickets, num_closed_tickets, avg_resolution_time, employee_id
	MANAGER: manager_id, dept_num_open_tickets, dept_num_resolved_tickets, 	dept_avg_resolution_time, agent_id, employee_id
	ACCOUNT: username, password
	TICKET: ticket_id, title, message, submitting_employee, assigned_agent, date_submitted, 	date_assigned, date_resolved, time_to_resolution, ticket_status

In order to achieve first normal form, the un-normalized EMPLOYEE relation is split into three new relations: EMPLOYEE, AGENT, and MANAGER. Each agent has an employee id, and each manager has an employee id as well as an agent id. The ROLE relation only has one attribute, so the name will serve as the unique identifier. The username for each account must be unique, so username will be the identifier for the ACCOUNT relation. All other relations use an invented identifier.

2NF Relations:

The relations already satisfy the conditions for second normal form.

3NF Relations:

	ROLE: name
	EMPLOYEE: employee_id, first_name, last_name, username
	AGENT: agent_id, employee_id
	MANAGER: manager_id, agent_id, employee_id
	ACCOUNT: username, password, role
	TICKET: ticket_id, title, message, submitting_employee, assigned_agent, date_submitted, 	date_assigned, date_resolved
	
To achieve third normal form, all calculated attributes have been removed, including open and resolved ticket totals, as well as average resolution time of each agent and the department as whole. Each of these can be calculated using attributes from the TICKET relation. The time_to_resolution calculated attribute has also been removed from the TICKET relation, as has ticket_status, which can be determined based on whether of not the value of date_resolved is NULL.

Physical Design

Tables:
	
	ROLE: name
	EMPLOYEE: employee_id, first_name, last_name, username
	AGENT: agent_id, employee_id, num_open_tickets, num_resolved_tickets
	MANAGER: manager_id, agent_id, employee_id, dept_open_tickets, dept_resolved_tickets
	ACCOUNT: username, password, role
	TICKET: ticket_id, title, message, submitting_employee, assigned_agent, date_submitted, 	date_assigned, date_resolved

For ease of calculation, total ticket number attributes have been restored to the AGENT and MANAGER tables.

The only optional foreign key value is in the TICKET table. A ticket may have a NULL assigned_to characteristic if it is open and has not yet been assigned to an agent. The date_submitted, date_assigned, and date_resolved attributes of the TICKET table will be used to calculate the time taken to resolve each ticket, and average resolution times for each agent individually as well as for the department overall. 
