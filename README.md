# Event Reminder

The **Event Reminder** is a simple web application based on **[Flask](https://flask.palletsprojects.com/en/1.1.x/)** framework, **[Bootstrap](https://getbootstrap.com/)** user interface framework and **[FullCalendar](https://fullcalendar.io/)** full-sized JavaScript calendar. 
 
The main purpose of the **Event Reminder** application is to send notifications about upcoming events to selected users. The application allows a standard user to enter event data, process it and display with the **FullCalendar** API. Moreover, the application has a built-in admin panel for the management of users, events, notification service, display app related logs and basic system info on app dashboard partly based on **[Chart.js](https://www.chartjs.org/)**. Sending reminder messages through the notification service is performed by third-party SMTP e-mail server and **Celery**/**Celery Readbeat** libraries.
The application has implemented integration with the **Elasticsearch** search engine.
***

## Getting Started

Below instructions will get you a copy of the project up and running on your local machine for development and testing purposes. 


### Requirements
Minimum version of python required to run the **Event Reminder** application - **Python 3.7.7**

Python third party packages:
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

### Installation

The application can be build locally with `virtualenv` tool. Run following commands in order to create virtual environment and install the required packages.

```bash
$ virtualenv venv
$ source venv/bin/activate
(venv) $ pip install -r requirements.txt
```

### Environment variables

Event Reminder application depends on some specific environment variables. 
To run application successfully the environment variables should be stored in `.env` file in the root application directory (`event-reminder` dir).

```
# '.env' file
SECRET_KEY=use-some-random-key
DEV_DATABASE_URL=sqlite:///app.db                   # example for SQLite for development
DATABASE_URL_SCHEDULAR=sqlite:///schedular.db   # example for SQLite
MAIL_SERVER=smtp.example.com
MAIL_PORT=587
MAIL_USERNAME=xxx.yyy@example.com               # account which will be used for SMTP email service
MAIL_PASSWORD=xxxxxxx                           # password for above account
ELASTICSEARCH_URL=http://localhost:9200         # optional
CELERY_BROKER_URL=redis://localhost:6379/0
CELERY_RESULT_BACKEND_URL=redis://localhost:6379/0
CELERY_REDBEAT_REDIS_URL=redis://localhost:6379/1
```
The `.env` file will be imported by application on startup.

### Elasticsearch server
Elasticsearch is not required to run the Event Reminder application. Without the specified 'ELASTICSEARCH_URL' variable and/or running the Elasticsearch node, the application will run, but no search function will be available.

The fastest and easiest way to start Elasticsearch node is to run it in Docker container.
You can obtain Elasticsearch for Docker issuing below command (examples for 7.7.0 version):
```bash
$ docker pull docker.elastic.co/elasticsearch/elasticsearch:7.7.0
``` 
Then start a single node cluster with Docker:
```bash
$ docker run --name elasticsearch -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" docker.elastic.co/elasticsearch/elasticsearch:7.7.0
```

***

## Running the App

Before running the Event Reminder app you can use script `init_db.py` to initialize database and add some dummy data that can be used later in the processing.
```bash
(venv) $ cd reminder
(venv) $ python init_db.py
```

After adding dummy data, you can start the application. First of all set the `FLASK_APP` environment variable to point `run.py` script and then invoke `flask run` command.
```bash
# On the first terminal run:
(venv) $ export FLASK_APP=run.py
# in MS Windows OS run 'set FLASK_APP=run.py'
(venv) $ cd ..
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