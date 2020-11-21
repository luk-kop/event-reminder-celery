import datetime

from reminder.extensions import celery, db, cache
from flask import current_app
from reminder.models import Event
from reminder.admin import smtp_mail


@celery.task(name='dummy_task')
def dummy_task():
    print('---Dummy Task---')


@celery.task(name='notify_async_check')
def notify_async_check():
    """
    Background task to check the event notification status and send notification email.
    """
    today = datetime.datetime.utcnow().strftime("%Y-%m-%d %H:%M")
    events_to_notify = Event.query.filter(Event.time_notify <= today,
                                          Event.is_active == True,
                                          Event.to_notify == True,
                                          Event.notification_sent == False).all()
    try:
        for event in events_to_notify:
            users_to_notify = [user for user in event.notified_users]
            smtp_mail.send_email('Attention! Upcoming event!',
                                 users_to_notify,
                                 event,
                                 cache.get('mail_server'),
                                 cache.get('mail_port'),
                                 cache.get('mail_security'),
                                 cache.get('mail_username'),
                                 cache.get('mail_password'))
            current_app.logger_admin.info(f'Notification service: notification has been sent to: {users_to_notify}')
            # only for test
            print(f'Mail sent to {users_to_notify}')
            event.notification_sent = True
        db.session.commit()
    except Exception as error:
        current_app.logger_admin.error(f'Background job error: {error}')
        # Remove job when error occure.
        # scheduler.remove_job('my_job_id')