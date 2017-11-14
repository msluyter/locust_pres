FROM python:3.6

# Set to ensure the python buffering for stdout doesn't keep the info we want out of the logs.
ENV PYTHONUNBUFFERED 1

ADD requirements.txt /locust_demo/requirements.txt

# Install all necessary python packages
RUN pip install -r /locust_demo/requirements.txt

# Copy the tasks
COPY ./locustfile.py /locust_demo/locustfile.py
COPY ./run.sh /locust_demo/run.sh

# Expose the required Locust ports
EXPOSE 5557 5558 8089

# Set script to be executable
RUN chmod 755 /locust_demo/run.sh

CMD /locust_demo/run.sh
