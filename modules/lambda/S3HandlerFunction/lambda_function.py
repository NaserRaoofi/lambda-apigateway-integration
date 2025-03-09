import json
import boto3
import os

# Initialize S3 client
s3 = boto3.client('s3')
BUCKET_NAME = os.getenv("BUCKET_NAME", "my-api-s3-bucket-v1")  # Use environment variable if available

def lambda_handler(event, context):
    """Handles file upload and retrieval from S3 via API Gateway"""
    http_method = event.get("httpMethod", "")

    if http_method == "PUT":
        return upload_file(event)
    
    elif http_method == "GET":
        return list_files(event)
    
    else:
        return {
            "statusCode": 400,
            "headers": {"Content-Type": "application/json"},  # Fix CORS issue
            "body": json.dumps({"error": "Unsupported HTTP method"})
        }

def upload_file(event):
    """Uploads a file to S3"""
    try:
        body = json.loads(event.get("body", "{}"))  # Avoids errors if body is missing
        file_name = body.get("file_name")
        file_content = body.get("file_content")  # Base64 encoded content
        
        if not file_name or not file_content:
            return {"statusCode": 400, "body": json.dumps({"error": "Missing parameters"})}
        
        # Convert Base64 content back to binary
        file_data = bytes(file_content, "utf-8")

        # Upload to S3
        s3.put_object(Bucket=BUCKET_NAME, Key=file_name, Body=file_data)

        return {
            "statusCode": 200,
            "headers": {"Content-Type": "application/json"},
            "body": json.dumps({"message": "File uploaded successfully", "file_name": file_name})
        }
    
    except Exception as e:
        return {"statusCode": 500, "headers": {"Content-Type": "application/json"}, "body": json.dumps({"error": str(e)})}

def list_files(event):
    """Lists all files in the S3 bucket"""
    try:
        objects = s3.list_objects_v2(Bucket=BUCKET_NAME)
        file_list = [obj["Key"] for obj in objects.get("Contents", [])] if "Contents" in objects else []
        
        return {
            "statusCode": 200,
            "headers": {"Content-Type": "application/json"},
            "body": json.dumps({"files": file_list})
        }
    
    except Exception as e:
        return {"statusCode": 500, "headers": {"Content-Type": "application/json"}, "body": json.dumps({"error": str(e)})}
