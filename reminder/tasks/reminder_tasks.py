import datetime

from reminder.extensions import celery, db, cache
from flask import current_app
from reminder.models import Event
from reminder.admin import smtp_mail


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
            if not users_to_notify:
                current_app.logger_admin.error(f'Background job error: Event with {event.id} id has no users to notify')
                continue
            # Return only notified users
            users_notified = smtp_mail.send_email(subject='Attention! Upcoming event!',
                                                  recipients=users_to_notify,
                                                  event=event,
                                                  mail_server=cache.get('mail_server'),
                                                  mail_port=cache.get('mail_port'),
                                                  mail_security=cache.get('mail_security'),
                                                  mail_sender=cache.get('mail_username'),
                                                  mail_pass=cache.get('mail_password'))
            current_app.logger_admin.info(f'Notification service: notification has been sent to: {users_notified}')
            # only for test
            print(f'Mail sent to {users_notified}')
            event.notification_sent = True
        db.session.commit()
    except Exception as error:
        current_app.logger_admin.error(f'Background job error: {error}')
        # Remove job when error occur.
        # scheduler.remove_job('my_job_id')