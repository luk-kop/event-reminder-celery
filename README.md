# Event Reminder

[![Python 3.7.7](https://img.shields.io/badge/python-3.8.5-blue.svg)](https://www.python.org/downloads/release/python-377/)
[![Flask 1.1.1](https://img.shields.io/badge/Flask-1.1.2-blue.svg)](https://flask.palletsprojects.com/en/1.1.x/)
[![MIT license](https://img.shields.io/badge/License-MIT-blue.svg)](https://lbesson.mit-license.org/)

The **Event Reminder** is a simple web application based on **[Flask](https://flask.palletsprojects.com/en/1.1.x/)** framework, **[Bootstrap](https://getbootstrap.com/)** UI framework and **[FullCalendar](https://fullcalendar.io/)** full-sized JavaScript calendar. 
 
The main purpose of the **Event Reminder** application is to send notifications about upcoming events to selected users. The application allows a standard user to enter event data, process it and display with the **FullCalendar** API. Moreover, the application has a built-in admin panel for the management of users, events, notification service, display app related logs and basic system info on app dashboard partly based on **[Chart.js](https://www.chartjs.org/)**. Sending reminder messages through the notification service is performed by third-party SMTP e-mail server and **Celery**/**Celery Readbeat** libraries.
The application has implemented integration with the **Elasticsearch** search engine.

## Branch details
The **Event Reminder** application has been designed in two versions with two different mechanisms to handle background (asynchronous) processes:
- **APScheduler** (`master` branch)
- **Celery** (`celery-version` branch)

This branch is dedicated for **Celery**. In order to change to `master` branch (APScheduler) use the following commands:
```bash
# After cloning the repository
cd event-reminder/
git checkout master
```

## Getting Started

Below instructions will get you a copy of the project up and running on your local machine for development and testing purposes. 


### Requirements

Project is created with the following Python third party packages:
* [Flask](https://flask.palletsprojects.com/en/1.1.x/)
* [Flask-SQLalchemy](https://flask-sqlalchemy.palletsprojects.com/en/2.x/)
* [Flask-WTF](https://flask-wtf.readthedocs.io/en/stable/)
* [Celery](https://docs.celeryproject.org/en/stable/index.html)
* [Celery Redbeat](https://pypi.org/project/celery-redbeat/)
* [Flask-Login](https://flask-login.readthedocs.io/en/latest/)
* [Flask-Caching](https://flask-caching.readthedocs.io/en/latest/)
* [Requests](https://requests.readthedocs.io/en/master/)
* [elasticsearch](https://pypi.org/project/elasticsearch/)
* [python-dotenv](https://pypi.org/project/python-dotenv/)
* [Flask-Session](https://flask-session.readthedocs.io/en/latest/)

### Installation

The application can be build locally with `virtualenv` tool. Run following commands in order to create virtual environment and install the required packages.

```bash
$ virtualenv venv
$ source venv/bin/activate
(venv) $ pip install -r requirements.txt
```

### Environment variables

The **Event Reminder** application depends on some specific environment variables. 
To run application successfully the environment variables should be stored in `.env` file in the root application directory (`event-reminder` dir).

Replace the values in `.env-example` with your own values and rename this file to `.env`
```
# '.env' file example:
SECRET_KEY=use-some-random-key
APPLICATION_MODE='development'                      # for development will use SQLite db
# APPLICATION_MODE='production'                     # for production will use PostgreSQL db
DEV_DATABASE_URL=sqlite:///app.db                   # example for SQLite
PROD_DATABASE_URL=postgresql://reminderuser:password@db:5432/reminderdb     # example for PostgreSQL
MAIL_SERVER=smtp.example.com
MAIL_PORT=587
MAIL_USERNAME=your.email@example.com                # account which will be used for SMTP email service
MAIL_PASSWORD=yourpassword                          # password for above account
CHECK_EMAIL_DOMAIN='False'                          # if 'True' validate whether email domain/MX record exist
ELASTICSEARCH_URL=http://localhost:9200             # optional
CELERY_BROKER_URL=redis://localhost:6379/0          # Celery config
CELERY_RESULT_BACKEND_URL=redis://localhost:6379/0
CELERY_REDBEAT_REDIS_URL=redis://localhost:6379/1
SESSION_REDIS=redis://localhost:6379/2              # session-server
```
The `.env` file will be imported by application on startup.

### Elasticsearch server
Elasticsearch is not required to run the **Event Reminder** application. Without the specified `ELASTICSEARCH_URL` variable and/or running the Elasticsearch node, the application will run, but no search function will be available.

The fastest and easiest way to start Elasticsearch node is to run it in Docker container.
You can obtain Elasticsearch for Docker issuing below command (examples for 7.7.0 version):
```bash
$ docker pull docker.elastic.co/elasticsearch/elasticsearch:7.7.0
``` 
Then start a single node cluster with Docker:
```bash
$ docker run --name elasticsearch -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" -d docker.elastic.co/elasticsearch/elasticsearch:7.7.0
```
### Redis server
Redis server is required to start application. Redis is used as a session server (server-side) and Celery broker. 

The fastest and easiest way to start Redis is to run it in Docker container.
```bash
$ docker run --name redis-event -d -p 6379:6379 redis
```


## Running the App

Before running the **Event Reminder** app you can use script `init_db.py` to initialize database and add some dummy data that can be used later in the processing.
```bash
# Below script will create default admin username 'admin' with password 'admin'
(venv) $ python init_db.py
# You can create a different user instead of the default one using proper options. Below example for username 'bob' with password 'LikePancakes123#'.
(venv) $ python init_db.py -u bob -p LikePancakes123#
# For more info please use:
(venv) $ python init_db.py --help
```

After adding dummy data, you can start the application. First of all set the `FLASK_APP` environment variable to point `run.py` script and then invoke `flask run` command.
```bash
# On the first terminal run:
(venv) $ cd reminder/
(venv) $ export FLASK_APP=run.py
# in MS Windows OS run 'set FLASK_APP=run.py'
(venv) $ flask run
```

In order to use the notification service correctly, the Celery Beat and Celery Worker should be activated.
They can be run in two ways: for the development or production environment.  
- For development or test purposes you can run Celery Beat and Celery Worker on the same terminal:
```bash
# Run another (second) terminal session and enter the following commands:
source venv/bin/activate
(venv} $ celery -A reminder.celery_app:app worker --beat --loglevel=info
```
- For production purposes you should run Celery Beat and Celery Worker on two separate terminals:
```bash
# On the second terminal run a Celery Worker
source venv/bin/activate
(venv} $ celery -A reminder.celery_app:app worker --loglevel=info

# On the third terminal run a Celery Beat
source venv/bin/activate
(venv} $ celery -A reminder.celery_app:app beat --loglevel=info
```