# TicketTracker
CS157A Final Project

DESIGN SUMMARY

Conceptual Design

There are three views available to three different roles in the company: an employee view, an agent view, and a manager view. A regular employee should be able to submit a new ticket and view the tickets they have previously submitted. An agent should be able to view unassigned tickets, assign a ticket to themselves, view their assigned tickets, and change the status of a ticket (open or resolved). An agent should additionally be able to view their own statistics including total numbers of open and closed tickets, and average amount of time spent resolving a ticket. A manager should be able to view the stats of all of their agents as well as the tickets assigned to each agent, and they should be able to view general stats for the department. To complicate matters, agents and managers are both employees, and managers are also agents.

Conceptual Entities and Attributes:
	
ROLE: name
EMPLOYEE: first_name, last_name, manager, role, (ticket_submitted, date_submitted, assigned_agent, ticket_status, date_resolved), (ticket_assigned, date_assigned, 	submitting_employee, ticket_status, date_resolved), num_open_tickets, num_closed_tickets, avg_resolution_time), (employee, first_name, last_name, (tickets_assigned), num_open_tickets, num_resolved_tickets, avg_resolution_time), department_num_tickets_assigned, department_avg_resolution_time
ACCOUNT: username, password
TICKET: title, message, submitting_employee, agent_assigned, date_submitted, date_assigned, date_resolved, time_to_resolution
	
Logical Design

1NF Relations:

ROLE: name
EMPLOYEE: employee_id, first_name, last_name, role
AGENT: agent_id, num_open_tickets, num_closed_tickets, avg_resolution_time, employee_id
MANAGER: manager_id, dept_num_open_tickets, dept_num_resolved_tickets, 	dept_avg_resolution_time, agent_id, employee_id
ACCOUNT: username, password
TICKET: ticket_id, title, message, submitting_employee, assigned_agent, date_submitted, date_assigned, date_resolved, time_to_resolution, ticket_status

In order to achieve first normal form, the un-normalized EMPLOYEE relation is split into three new relations: EMPLOYEE, AGENT, and MANAGER. Each agent has an employee id, and each manager has an employee id as well as an agent id. The ROLE relation only has one attribute, so the name will serve as the unique identifier. The username for each account must be unique, so username will be the identifier for the ACCOUNT relation. All other relations use an invented identifier.

2NF Relations:

The relations already satisfy the conditions for second normal form.

3NF Relations:

ROLE: name
EMPLOYEE: employee_id, first_name, last_name, username
AGENT: agent_id, employee_id
MANAGER: manager_id, agent_id, employee_id
ACCOUNT: username, password, role
TICKET: ticket_id, title, message, submitting_employee, assigned_agent, date_submitted, date_assigned, date_resolved
	
To achieve third normal form, all calculated attributes have been removed, including open and resolved ticket totals, as well as average resolution time of each agent and the department as whole. Each of these can be calculated using attributes from the TICKET relation. The time_to_resolution calculated attribute has also been removed from the TICKET relation, as has ticket_status, which can be determined based on whether of not the value of date_resolved is NULL.

Physical Design

Tables:
	
ROLE: name
EMPLOYEE: employee_id, first_name, last_name, username
AGENT: agent_id, employee_id, num_open_tickets, num_resolved_tickets
MANAGER: manager_id, agent_id, employee_id, dept_open_tickets, dept_resolved_tickets
ACCOUNT: username, password, role
TICKET: ticket_id, title, message, submitting_employee, assigned_agent, date_submitted, date_assigned, date_resolved

For ease of calculation, total ticket number attributes have been restored to the AGENT and MANAGER tables.

The only optional foreign key value is in the TICKET table. A ticket may have a NULL assigned_to characteristic if it is open and has not yet been assigned to an agent. The date_submitted, date_assigned, and date_resolved attributes of the TICKET table will be used to calculate the time taken to resolve each ticket, and average resolution times for each agent individually as well as for the department overall. 
