from reminder import init_celery


app = init_celery()
app.conf.imports = app.conf.imports + ('reminder.tasks.reminder_tasks',)