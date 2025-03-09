# AWS Lambda, S3, and API Gateway Integration

![df](https://github.com/user-attachments/assets/0b4dbc4f-046b-4259-a92c-6866d56c979e)


## 📌 Overview
This project implements a **serverless API** that allows users to upload and retrieve files from an **Amazon S3 bucket** using **AWS Lambda** and **API Gateway**.

- **AWS Lambda** processes API requests.
- **Amazon S3** stores uploaded files.
- **API Gateway** exposes RESTful endpoints for users to interact with S3.
- **Terraform** automates infrastructure provisioning.

---

## 🚀 **Features**
- **Upload files** to S3 via API Gateway (PUT request).
- **Retrieve file list** from S3 (GET request).
- **IAM Role Permissions** ensuring Lambda has access to S3.
- **Terraform Infrastructure-as-Code (IaC)** for automation.

---

## 🏗️ **Architecture**
1. **API Gateway** receives the request (`PUT` or `GET`).
2. **Lambda Function** processes the request.
3. **S3 Bucket** stores or retrieves the requested files.
4. **IAM Roles & Policies** ensure secure access.

---

## 📜 ** Project Structure**
```
aws-lambda-s3-api-gateway/
│── environments/
│   └── dev/
│       ├── main.tf             # Calls S3, IAM, Lambda, and API Gateway modules
│── modules/
│   ├── s3/
│       ├── main.tf             # S3 bucket and policy
│       ├── variables.tf        
│       ├── outputs.tf          
│   ├── iam/
│       ├── main.tf             # IAM Role & Permissions for Lambda
│       ├── variables.tf        
│       ├── outputs.tf          
│   ├── lambda/
│   │   ├── main.tf             # Lambda function definition
│       ├── variables.tf       
│       ├── outputs.tf          
│   │   ├── lambda_function.py          # Lambda function code
│   │   ├── lambda_function.zip # Packaged Lambda function
│   ├── api-gateway/
│       ├── main.tf             # API Gateway setup
│       ├── variables.tf        
│       ├── outputs.tf          
│── README.md                   # Project documentation

