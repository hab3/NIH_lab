# Project description
## Background:


At the National Institutes of Health (NIH) Laboratories, we leverage Amazon Web Services
(AWS) EC2 instances for critical computational research activities. However, these instances
are often left running by our scientists outside of operational hours, leading to unnecessary
costs. The existing process lacks an automated way to manage the lifecycle of these instances
and does not provide visibility into the actions taken on these resources.


## Objective:


Our goal is to develop an automated solution for managing the lifecycle of specific AWS EC2
instances, which includes not only controlling their operational hours but also providing real-time
notifications regarding their status. The objectives are twofold:


### Automated Instance Management: Implement a system to automatically start production
instances at 6:00 PM and stop them at 7:00 PM daily. This will optimize costs and
resource usage.


### Real-Time Notifications via Amazon SNS: Integrate Amazon Simple Notification Service
(SNS) to send email notifications detailing the actions taken on these instances, enhancing
transparency and communication among the team.



## Prerequisites
Requirements:


Selective Instance Targeting: The system must identify and target only specific instances
intended for automated management, avoiding any disruption to instances that require
continuous operation.


SNS Integration for Notifications: Integrate AWS SNS to send email notifications
post-instance termination and start-up, providing details such as instance IDs and action
timestamps.


Comprehensive Logging and Alerting: Maintain logs of all actions and send alerts for any
errors or deviations from expected behavior.


## Desired Outcome:
By implementing this enhanced solution, we anticipate a significant reduction in operational
costs and improved resource efficiency. The addition of SNS notifications will ensure that our
scientists and management are always informed about the status of our EC2 resources,
fostering a more proactive approach to resource management within NIH Laboratories.





## STEPS
Create EC2 instances. Tag some instances as Development and others as Production
Create IAM role for Lambda 
Craete IAM Policy for Lambda to start and stop EC2. Attach Policy to role.
Create Lambda function to start and stop ONLY production instatnces and attach the Lambda Role
Create 2 Eventbridge Rules to trigger the function. One to start production instances at 6pm and one to stop the instances at 7pm
Create SNS topic to receive notifications of every start and stop event.
Ensure that all events are logged on cloudwatch logs#   N I H _ l a b 
 
 
