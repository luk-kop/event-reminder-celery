import os

# basedir = os.path.abspath(os.path.dirname(__file__))


class Config:
    """
    Set Flask configuration vars.
    """
    # General Config
    SECRET_KEY = os.environ.get('SECRET_KEY')
    JSONIFY_PRETTYPRINT_REGULAR = True
    # Cookies lifetime is 1800 sek (30 min).
    # PERMANENT_SESSION_LIFETIME = 1800

    # Database Config
    SQLALCHEMY_DATABASE_URI = os.environ.get('DATABASE_URL') or 'sqlite:///app.db'
    #    'sqlite:///' + os.path.join(basedir, 'app.db')
    SQLALCHEMY_TRACK_MODIFICATIONS = False

    # Custom Config
    USER_DEFAULT_PASS = os.environ.get('USER_DEFAULT_PASS')

    # Email config
    # MAIL_SERVER = os.environ.get('MAIL_SERVER')
    # MAIL_PORT = int(os.environ.get('MAIL_PORT') or 25)
    # MAIL_USE_TLS = os.environ.get('MAIL_USE_TLS') is not None
    # MAIL_USERNAME = os.environ.get('MAIL_USERNAME')
    # MAIL_PASSWORD = os.environ.get('MAIL_PASSWORD')
    # ADMINS = ['janek.exo@wp.pl']
