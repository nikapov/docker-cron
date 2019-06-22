FROM ubuntu:latest

# Install cron
RUN apt-get update
RUN apt-get -y install cron
RUN apt-get -y install bluez
RUN apt-get -y install python
RUN apt-get -y install python-pip
RUN apt-get -y install build-essential
RUN apt-get -y install libglib2.0-dev
RUN pip install bluepy
RUN pip install paho-mqtt

# Add crontab file in the cron directory
ADD crontab /etc/cron.d/simple-cron

# Add oregon.py file 
ADD oregon.py /oregon.py

# Add shell script and grant execution rights
ADD script.sh /script.sh
RUN chmod +x /script.sh

# Give execution rights on the cron job
RUN chmod 0644 /etc/cron.d/simple-cron

# Create the log file to be able to run tail
RUN touch /var/log/cron.log

# Run the command on container startup
CMD cron && tail -f /var/log/cron.log
