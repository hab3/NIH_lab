import json
import boto3
import datetime

def lambda_handler(event, context):
    # Initialize the EC2 client
    ec2 = boto3.client('ec2')
    # Get current time
    current_time = datetime.datetime.utcnow()
    
    # Check if it's 6PM or 7PM
    if current_time.hour == 22:
        # Start instances tagged "production"
        start_instances(ec2, "production")
    elif current_time.hour == 23:
        # Stop instances tagged "production"
        stop_instances(ec2, "production")
    else:
        print("not time yet!")
 

def start_instances(ec2, tag_value):
    # Get instances with the specified tag value
    instances = ec2.describe_instances(
        Filters=[
            {'Name': 'tag:Name', 'Values': [tag_value]}
        ]
    )['Reservations']
    
    # Start each instance
    for reservation in instances:
        for instance in reservation['Instances']:
            instance_id = instance['InstanceId']
            ec2.start_instances(InstanceIds=[instance_id])
            print(f"Instance {instance_id} started.")

def stop_instances(ec2, tag_value):
    # Get instances with the specified tag value
    instances = ec2.describe_instances(
        Filters=[
            {'Name': 'tag:Name', 'Values': [tag_value]}
        ]
    )['Reservations']
    
    # Stop each instance
    for reservation in instances:
        for instance in reservation['Instances']:
            instance_id = instance['InstanceId']
            ec2.stop_instances(InstanceIds=[instance_id])
            print(f"Instance {instance_id} stopped.")
