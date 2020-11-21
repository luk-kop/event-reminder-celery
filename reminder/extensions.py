"""Extensions module. Each extension is initialized in the app factory located in __init__.py."""
from flask_sqlalchemy import SQLAlchemy
from flask_login import LoginManager
from flask_apscheduler import APScheduler
from flask_wtf.csrf import CSRFProtect
from flask_caching import Cache
from celery import Celery


db = SQLAlchemy()
login_manager = LoginManager()
csrf = CSRFProtect()
scheduler = APScheduler()
cache = Cache()
celery = Celery()
