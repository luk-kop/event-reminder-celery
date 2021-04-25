import os
from pathlib import Path

from dotenv import load_dotenv
import redis


basedir = Path(__file__).resolve().parent
load_dotenv(os.path.join(basedir, '.env'))
# Set base dir for SQLite db
if os.environ.get('APPLICATION_MODE') == 'development':
    db_url = os.environ.get('DEV_DATABASE_URL')
else:
    db_url = os.environ.get('PROD_DATABASE_URL')
if db_url.startswith('sqlite:///'):
    db_url = f'sqlite:///{basedir}/{db_url.split("///")[1]}'


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
    CACHE_TYPE = 'RedisCache'
    CACHE_REDIS_URL = os.environ.get('CACHE_REDIS')
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
    }
    # Server-Side session config
    SESSION_TYPE = 'redis'
    SESSION_REDIS = redis.from_url(os.environ.get('SESSION_REDIS'))


class ProdConfig(Config):
    """
    Set Flask configuration vars for production.
    """
    SQLALCHEMY_DATABASE_URI = db_url


class DevConfig(Config):
    """
    Set Flask configuration vars for development.
    """
    DEBUG = True
    SQLALCHEMY_DATABASE_URI = db_url


class TestConfig(Config):
    """
    Set Flask configuration vars for testing.
    """
    # Globally turn off authentication (when unit testing)
    LOGIN_DISABLED = True
    DEBUG = True
    TESTING = True
    SQLALCHEMY_DATABASE_URI = db_url