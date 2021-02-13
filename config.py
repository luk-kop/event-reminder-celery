import os
from pathlib import Path
from datetime import timedelta

from dotenv import load_dotenv
from apscheduler.jobstores.sqlalchemy import SQLAlchemyJobStore


basedir = Path(__file__).resolve().parent
load_dotenv(os.path.join(basedir, '.env'))


class Config:
    """
    Set base Flask configuration vars.
    """
    # General Config
    DEBUG = False
    TESTING = False
    SECRET_KEY = os.environ.get('SECRET_KEY')
    JSONIFY_PRETTYPRINT_REGULAR = True
    LOGS_DIR = basedir.joinpath('logs')
    ELASTICSEARCH_URL = os.environ.get('ELASTICSEARCH_URL')
    # Cookies lifetime is 1800 sek (30 min).
    PERMANENT_SESSION_LIFETIME = 1800
    STATIC_FOLDER = 'static'
    # Cache Config
    CACHE_TYPE = 'filesystem'
    CACHE_DIR = basedir.joinpath('tmp')
    CACHE_DEFAULT_TIMEOUT = 0
    # Database Config
    SQLALCHEMY_TRACK_MODIFICATIONS = False
    # Email Config
    MAIL_SERVER = os.environ.get('MAIL_SERVER')
    MAIL_PORT = os.environ.get('MAIL_PORT')
    MAIL_SECURITY = 'tls'
    MAIL_USERNAME = os.environ.get('MAIL_USERNAME')
    MAIL_DEFAULT_SENDER = os.environ.get('MAIL_USERNAME')
    MAIL_PASSWORD = os.environ.get('MAIL_PASSWORD')
    # Check (validate) user's email address domain
    CHECK_EMAIL_DOMAIN = True if os.environ.get('CHECK_EMAIL_DOMAIN').lower() == 'True' else False
    # Celery Config
    CELERY = {
        'broker_url': os.environ.get("CELERY_BROKER_URL"),
        'result_backend': os.environ.get("CELERY_RESULT_BACKEND_URL"),
        'redbeat_redis_url': os.environ.get('CELERY_REDBEAT_REDIS_URL'),
        'beat_scheduler': 'redbeat.RedBeatScheduler',
        'redbeat_key_prefix': 'redbeat:',
        'beat_max_loop_interval': 5,
        'beat_schedule': {}
        # 'beat_schedule': {
        #     'time_scheduler': {
        #         # 'task': 'reminder.tasks.example.dummy_task',
        #         'task': 'dummy_task',
        #         'schedule': 10.0,
        #     }
        # }
    }


class ProdConfig(Config):
    """
    Set Flask configuration vars for production.
    """
    SQLALCHEMY_DATABASE_URI = os.environ.get('PROD_DATABASE_URL')


class DevConfig(Config):
    """
    Set Flask configuration vars for development.
    """
    DEBUG = True
    SQLALCHEMY_DATABASE_URI = os.environ.get('DEV_DATABASE_URL')


class TestConfig(Config):
    """
    Set Flask configuration vars for testing.
    """
    # Globally turn off authentication (when unit testing)
    LOGIN_DISABLED = True
    DEBUG = True
    TESTING = True
    SQLALCHEMY_DATABASE_URI = os.environ.get('DEV_DATABASE_URL')