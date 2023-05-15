DROP TABLE Role;
CREATE TABLE Role(
	name VARCHAR(16) PRIMARY KEY NOT NULL
);

INSERT INTO Role(name) VALUES ('employee');
INSERT INTO Role(name) VALUES ('agent');
INSERT INTO Role(name) VALUES ('manager');

DROP TABLE Account;
CREATE TABLE Account(
	username VARCHAR(32) PRIMARY KEY NOT NULL,
	password VARCHAR(32) NOT NULL,
	role VARCHAR(16) NOT NULL,
	FOREIGN KEY (role) REFERENCES Role(name)
);

DROP TABLE Employee;
CREATE TABLE Employee(
	employee_id INT PRIMARY KEY NOT NULL,
	first_name VARCHAR(64) NOT NULL,
	last_name VARCHAR(64) NOT NULL,
	username VARCHAR(32) NOT NULL,
	FOREIGN KEY (username) REFERENCES Account(username)
);

DROP TABLE Agent;
CREATE TABLE Agent(
	agent_id INT PRIMARY KEY NOT NULL,
	num_open_tickets INT NOT NULL,
	num_resolved_tickets INT NOT NULL,
	employee_id INT NOT NULL,
	FOREIGN KEY (employee_id) REFERENCES Employee(employee_id)
);

DROP TABLE Manager;
CREATE TABLE Manager(
	manager_id INT PRIMARY KEY NOT NULL,
	dept_open_tickets INT NOT NULL,
	dept_resolved_tickets INT NOT NULL,
	agent_id INT NOT NULL,
	employee_id INT NOT NULL,
	FOREIGN KEY (agent_id) REFERENCES Agent(agent_id),
	FOREIGN KEY (employee_id) REFERENCES Employee(employee_id)
);

DROP TABLE Ticket;
CREATE TABLE Ticket (
	ticket_id INT PRIMARY KEY NOT NULL,
	title VARCHAR(128) NOT NULL,
	message TEXT,
	date_submitted INT NOT NULL,
	date_assigned INT,
	date_resolved INT,
	submitted_by INT NOT NULL,
	assigned_to INT,
	FOREIGN KEY (submitted_by) REFERENCES Employee(employee_id),
	FOREIGN KEY (assigned_to) REFERENCES Agent(agent_id)
);